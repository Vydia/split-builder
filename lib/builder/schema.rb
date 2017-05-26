module SplitBuilder
  class Schema

    def self.define(&block)
      new(&block)
    end

    def initialize(&block)
      instance_exec(&block)
    end

    public

    def get_metric_by_name(metric_name)
      metrics.fetch(metric_name)
    end

    def goals
      @goals ||= []
    end

    def metrics
      @metrics ||= {}
    end

    def experiments
      @experiments ||= []
    end

    private

    # Builder DSL

    def goal(goal_name)
      goals << goal_name
    end

    def metric(metric_name, &block)
      if metrics.key?(metric_name)
        raise MetricAlreadyDefinedError, "Can't define another metric with the same name: #{metric_name.inspect}"
      end

      metrics[metric_name] = Metric.define(metric_name, &block)
    end

    def experiment(experiment_name, &block)
      experiments << Experiment.define(experiment_name, &block)
    end

  end
end
