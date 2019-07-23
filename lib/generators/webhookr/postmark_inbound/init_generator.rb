require 'generators/webhookr/init_generator'

module Webhookr
  module PostmarkInbound
    module Generators
      class InitGenerator < Webhookr::Generators::InitGenerator

        desc "This generator updates the named initializer with PostmarkInbound options"
        def init
          super
          append_to_file "config/initializers/#{file_name}.rb" do
            plugin_initializer_text
          end
        end

        def plugin_initializer_text
          "\nWebhookr::PostmarkInbound::Adapter.config.security_token = '#{generate_security_token}'" +
          "\n# Uncomment the next line to include your custom PostmarkInbound handler\n" +
          "# <-- Webhookr::PostmarkInbound::Adapter.config.callback = your_custom_class --> \n"
        end
      end
    end
  end
end
