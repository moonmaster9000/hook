require_relative '../lib/hook'

describe Hook do
  A_METHOD_RETURN_VALUE = 1

  let(:klass) do
    Class.new do
      include Hook

      +hook
      def a_method
        A_METHOD_RETURN_VALUE
      end
    end
  end

  describe ".hook" do
    it "should cause before hooks to run before the method is called" do
      var_set_before = nil

      klass.hook_before(:a_method) do
        var_set_before = "foo"
      end

      expect { klass.new.a_method }.to change { var_set_before }.from(nil).to "foo"
    end

    it "should cause after hooks to run after the method is called" do
      var_set_after = nil

      klass.hook_after(:a_method) do
        var_set_after = "bar"
      end

      expect { klass.new.a_method }.to change { var_set_after }.from(nil).to "bar"
    end

    it "should cause around hooks to run before and after the method is called" do
      var_set_around = 0

      klass.hook_around(:a_method) do
        var_set_around += 1
      end

      expect { klass.new.a_method }.to change { var_set_around }.from(0).to 2
    end

    it "should not affect the return value of the method" do
      klass.hook_around :a_method do
        rand
      end

      klass.new.a_method.should == A_METHOD_RETURN_VALUE
    end
  end

  describe ".remove_callbacks" do
    it "should remove any callbacks on the specified method" do
      klass.hook_before(:a_method) {}
      klass.hook_after(:a_method) {}
      klass.hook_around(:a_method) {}

      klass.before_hooks.should_not be_empty
      klass.after_hooks.should_not be_empty
      klass.around_hooks.should_not be_empty

      klass.remove_callbacks!(:a_method)

      klass.before_hooks[:a_method].should be_empty
      klass.after_hooks[:a_method].should be_empty
      klass.around_hooks[:a_method].should be_empty
    end
  end

  describe ".remove_all_callbacks" do
    it "should remove any callbacks on the specified method" do
      klass.hook_before(:a_method) {}
      klass.hook_after(:a_method) {}
      klass.hook_around(:a_method) {}

      klass.before_hooks.should_not be_empty
      klass.after_hooks.should_not be_empty
      klass.around_hooks.should_not be_empty

      klass.remove_all_callbacks!

      klass.before_hooks.should be_empty
      klass.after_hooks.should be_empty
      klass.around_hooks.should be_empty
    end
  end
end
