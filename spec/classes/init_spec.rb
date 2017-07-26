require 'spec_helper'
describe 'ambari' do
  context 'with default values for all parameters' do
    it { should contain_class('ambari') }
  end
end
