require 'method_decorators'

module Hook
  def self.included(base)
    base.extend ::Hook::ClassMethods
    base.extend ::MethodDecorators
  end

  class HookDecorator < MethodDecorator
    def call(wrapped, *args, &block)
      method_name = wrapped.name.to_s
      receiver = wrapped.receiver
      owner = wrapped.owner

      run_hooks owner.around_hooks[method_name], receiver
      run_hooks owner.before_hooks[method_name], receiver
      return_value = wrapped.call *args, &block
      run_hooks owner.after_hooks[method_name], receiver
      run_hooks owner.around_hooks[method_name], receiver

      return_value
    end

    private
    def run_hooks(hooks, object)
      hooks.each {|hook| hook.call object}
    end
  end

  module ClassMethods
    def hook
      ::Hook::HookDecorator
    end

    def hook_before method, &block 
      before_hooks[method.to_s] << block
    end

    def hook_after method, &block 
      after_hooks[method.to_s] << block
    end

    def hook_around method, &block 
      around_hooks[method.to_s] << block
    end

    def remove_callbacks! method
      [before_hooks, after_hooks, around_hooks].each do |hooks|
        hooks[method.to_s] = []
      end
    end

    def remove_all_callbacks!
      @before_hooks = nil
      @after_hooks = nil
      @around_hooks = nil
    end

    def before_hooks
      @before_hooks ||= scoped_callbacks
    end

    def after_hooks
      @after_hooks ||= scoped_callbacks
    end

    def around_hooks
      @around_hooks ||= scoped_callbacks
    end

    private
    def scoped_callbacks
      Hash.new {|h,k| h[k] = []}
    end
  end
end
