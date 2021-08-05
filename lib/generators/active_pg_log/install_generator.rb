require 'rails/generators/active_record'

module ActivePgLog
  module Generators
    class InstallGenerator < ::ActiveRecord::Generators::Base
      argument :name, type: :string, default: 'random_name'

      source_root File.expand_path('templates', __dir__)

      def install
        directory 'lib/tasks'
      end
    end
  end
end
