module Hook
  def self.included(base)
    base.extend ::Hook::ClassMethods
  end

  module ClassMethods
    def hook(method)
      self.instance_eval <<-HOOKS
        def before_#{method}(&block)
          before_hooks["#{method}"] << block
        end

        def after_#{method}(&block)
          after_hooks["#{method}"] << block
        end

        def around_#{method}(&block)
          around_hooks["#{method}"] << block
        end

        def remove_#{method}_callbacks!
          [before_hooks, after_hooks, around_hooks].each do |hooks|
            hooks["#{method}"] = []
          end
        end
      HOOKS
    end

    def remove_callbacks!
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

  private
  def with_hooks(method)
    method = method.to_s

    run_hooks self.class.around_hooks[method]
    run_hooks self.class.before_hooks[method]
    yield
    run_hooks self.class.after_hooks[method]
    run_hooks self.class.around_hooks[method]

    nil
  end

  def run_hooks(hooks)
    hooks.each {|hook| hook.call self}
  end
end
