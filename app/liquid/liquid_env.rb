# frozen_string_literal: true

module LiquidEnv
  def self.build
    Liquid::Environment.build do |env|
      Dir[Rails.root.join("app/liquid/tags/*.rb")].each do |file|
        require file

        tag_class = File.basename(file, ".rb").camelize.constantize
        tag_name = tag_class.name.demodulize.sub(/Tag$/, "").underscore

        env.register_tag(tag_name, tag_class)
      end
    end
  end

  def self.instance
    @liquid_env ||= build
  end
end
