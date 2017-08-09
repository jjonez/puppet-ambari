require 'spec_helper'
describe 'bdpenv' do
  context 'with default values for all parameters' do
    it { should contain_class('bdpenv') }
  end
end
