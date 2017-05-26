module SplitBuilder
  class Metric

    def self.define(metric_name, &block)
      new(metric_name, &block)
    end

    attr_reader :name

    def initialize(metric_name, &block)
      @name = metric_name
      instance_exec(&block) if block_given?
      goal(metric_name) if goals.empty?
    end

    def goals
      @goals ||= []
    end

    private

    # Builder DSL

    def goal(goal_name)
      goals << goal_name
    end

  end
end
