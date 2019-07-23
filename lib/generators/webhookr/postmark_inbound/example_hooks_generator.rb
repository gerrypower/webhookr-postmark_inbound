module Webhookr
  module PostmarkInbound
    module Generators

      class ExampleHooksGenerator < Rails::Generators::Base
        EXAMPLE_HOOK_FILE = 'app/models/postmark_inbound_hooks.rb'
        source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

        desc "Creates an example PostmarkInbound hook file: '#{EXAMPLE_HOOK_FILE}'"
        def example_hooks
          copy_file( "postmark_inbound_hooks.rb", EXAMPLE_HOOK_FILE)
        end
      end
    end
  end
end
