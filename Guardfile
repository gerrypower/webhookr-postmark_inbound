
guard 'minitest', :test_folders => 'test', :test_file_patterns => '*_tests.rb' do
  watch(%r|^test/(.+)_tests\.rb|)

  watch(%r|^lib/(.*)([^/]+)\.rb|) do |m|
    "test/#{m[1]}#{m[2]}_tests.rb"
  end

  watch(%r|^test/test_helper\.rb|) do
    "test"
  end
end


if File.exists?('Guardfile.local')
  instance_eval File.read('Guardfile.local')
end
