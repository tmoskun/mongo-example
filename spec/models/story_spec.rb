require 'spec_helper'

describe Story, 'valid' do
  it { should belong_to :user }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :title }
  it { should validate_presence_of :url}
  it { should validate_format_of(:url).with($URL_REGEX)}
end
