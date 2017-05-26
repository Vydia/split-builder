module SplitBuilder
  class Experiment

    def self.define(experiment_name, &block)
      new(experiment_name, &block)
    end

    attr_reader :name, :metric_name

    def initialize(experiment_name, &block)
      @name = experiment_name
      instance_exec(&block)
    end

    def alternatives
      @alternatives ||= []
    end

    private

    # Builder DSL

    def metric(metric_name, &block)
      if @metric_name
        raise ExperimentAlreadyHasMetricError, "An experiment may not have more than one metric."
      end

      @metric_name = metric_name
    end

    def alternative(alternative_name, options = {})
      # TODO: class Alternative
      alternatives << options.merge(:name => alternative_name)
    end

  end
end
