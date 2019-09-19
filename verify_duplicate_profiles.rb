require 'pathname'

class InputDevice
  attr_reader :filename, :input_device, :input_vendor_id, :input_product_id

  def initialize(filename:, input_device:, input_vendor_id:, input_product_id:)
    @filename = filename
    @input_device = input_device
    @input_vendor_id = input_vendor_id
    @input_product_id = input_product_id
  end

  def self.from_file(file)
    parsed_file = Hash[file.read.scan(/^([^#\s]+)\s*=\s*"?([^"\n]+)"?/)]

    new(
      filename: file.to_s,
      input_device: parsed_file['input_device'],
      input_vendor_id: parsed_file['input_vendor_id'],
      input_product_id: parsed_file['input_product_id'],
    )
  end

  def unique_identifier
    [input_vendor_id, input_product_id, input_device].join("-")
  end

  def disabled?
    input_vendor_id.nil? && input_product_id.nil? && input_device.nil?
  end

  def report_attributes
    [
      "Vendor ID: #{report_value(input_vendor_id)}",
      "Product ID: #{report_value(input_product_id)}",
      "Name: #{report_value(input_device)}"
    ].join(" - ")
  end

  def report_value(value)
    value || "empty"
  end
end

def input_devices_from(files)
  files.map { |f| InputDevice.from_file(f) }.reject(&:disabled?)
end

def config_files_per_driver
  Pathname.glob('*/*.cfg').group_by(&:parent)
end

def find_duplicates
  config_files_per_driver.each_with_object(Hash.new) do |(driver, cfg_files), duplicates|
    duplicate_devices = input_devices_from(cfg_files).
                        group_by(&:unique_identifier).
                        select { |id, devices| devices.size > 1 }

    duplicates[driver.to_s] = duplicate_devices unless duplicate_devices.empty?
  end
end

def colorize(text, color_code)
  "#{color_code}#{text}\e[0m"
end

def green(text); colorize(text, "\e[32m"); end
def red(text); colorize(text, "\e[31m"); end
def yellow(text); colorize(text, "\e[33m"); end


def report_duplicates(duplicates_per_driver)
  puts red("Some duplicate profiles were found")
  duplicates_per_driver.each do |driver_name, duplicates|
    puts green("Duplicates inside '#{driver_name}'")

    duplicates.each do |group_id, devices|
      puts yellow(devices.first.report_attributes)
      devices.each { |d| puts "- #{d.filename}" }
      puts "\n"
    end
  end
end

duplicates = find_duplicates

if duplicates.empty?
  puts green("No duplicate profiles were found")
  exit 0
else
  report_duplicates(duplicates)
  exit 1
end