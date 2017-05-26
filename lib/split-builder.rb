module SplitBuilder

  module_function

  # Given a SplitBuilder::Schema, get an experiments hash formatted for Split gem.
  def dump_experiments(schema)
    schema.experiments.each_with_object({}) do |experiment, experiments|
      metric = schema.get_metric_by_name(experiment.metric_name)

      experiments[experiment.name.to_s] = {
        :metric => metric.name,
        :goals => dump_goals(metric.goals, schema.goals),
        :alternatives => dump_alternatives(experiment.alternatives),
        :resettable => false # TODO: Pull from a default config.
      }
    end
  end

  # Private

  def dump_goals(metric_goals, schema_goals)
    undefined_goals = metric_goals - schema_goals

    if undefined_goals.any?
      raise UndefinedGoalError, "Goals #{undefined_goals.inspect} must be present in schema's defined goals: #{schema_goals.inspect}"
    end

    metric_goals.map(&:to_s)
  end

  def dump_alternatives(alternatives)
    alternatives.map do |options|
      {
        :name => options.fetch(:name).to_s,
        :percent => options.fetch(:percent, 50)
      }
    end
  end

end

require "builder/version"
require "builder/errors"
require "builder/experiment"
require "builder/metric"
require "builder/schema"
