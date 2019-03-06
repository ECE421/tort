require 'rake'

Gem::Specification.new do |s|
  s.name = 'tort'
  s.version = '0.0.0'
  s.licenses = ['MIT']
  s.summary = 'Multi-threaded / multi-processed sort for Ruby'
  s.description = 'Multi-threaded / multi-processed (merge sort based) sorting for Ruby.'
  s.authors = ['Nathan Klapstein', 'Thomas Lorincz']
  s.email = 'nklapste@ualberta.ca'
  s.homepage = 'https://github.com/ECE421/tort'

  s.files = FileList['lib/*.rb'].to_a
  s.test_files = FileList['test/*_test.rb'].to_a
end
