require 'test_helper'

class FileflockTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil Fileflock::VERSION
  end

  describe Fileflock do
    it 'initializes with argument' do
      file_path = '/tmp/foo.txt'

      Fileflock.new(file_path).must_be_kind_of(Fileflock)
    end
  end
end
