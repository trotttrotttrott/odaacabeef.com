require "resque-retry"
require "resque-retry/server"
require "resque/failure/redis"

Resque::Failure::MultipleWithRetrySuppression.classes = [Resque::Failure::Redis]
Resque::Failure.backend = Resque::Failure::MultipleWithRetrySuppression
