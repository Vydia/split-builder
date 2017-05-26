module SplitBuilder
  class BuilderError < StandardError; end
  class MetricAlreadyDefinedError < BuilderError; end
  class ExperimentAlreadyHasMetricError < BuilderError; end
  class UndefinedGoalError < BuilderError; end
end
