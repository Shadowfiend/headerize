require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../lib/headerize/javascript_helper.rb'

include Headerize

describe JavascriptHelper, 'when including a single file' do
  it 'should return nothing' do
    add_javascript('test').should be_nil
  end
end

describe JavascriptHelper, 'when including multiple files' do
  it 'should return nothing' do
    add_javascript('test', 'second_test', 'magic').should be_nil
  end
end

describe JavascriptHelper, 'when passing extra arguments to add_javascript' do
  it 'should return nothing' do
    add_javascript('test', 'magic', :cache => true).should be_nil
  end
end

describe JavascriptHelper, 'when outputting scripts without files' do
  it 'should return an empty string' do
    javascript_includes.should be_empty
  end
end

describe JavascriptHelper, 'when outputting with indentation but no scripts' do
  it 'should return an empty string' do
    javascript_includes(:indent => 8).should be_empty
  end
end

describe JavascriptHelper, 'when outputting scripts with a single file' do
  before(:each) do
    add_javascript 'test'
  end

  it 'should use javascript_include_tag to include it' do
    self.should_receive(:javascript_include_tag).with('test').and_return('test')

    javascript_includes.should == 'test'
  end
end

describe JavascriptHelper,
    'when outputting scripts with multiple add_javascript arguments' do
  before(:each) do
    add_javascript 'test', 'magic', :cache => true
  end

  it 'should splat the arguments to javascript_include_tag' do
    self.should_receive(:javascript_include_tag) \
        .with('test', 'magic', :cache => true).and_return('test')

    javascript_includes.should == 'test'
  end
end

describe JavascriptHelper,
    'when outputting scripts through multiple invocations' do
  before(:each) do
    add_javascript 'test'
    add_javascript 'test2', 'magic'
    add_javascript 'power'
  end

  it 'should call javascript_include_tag for each set ' +
     'and concatenate the results' do
    self.should_receive(:javascript_include_tag) \
        .with('test').and_return('test')
    self.should_receive(:javascript_include_tag) \
        .with('test2', 'magic').and_return('test2')
    self.should_receive(:javascript_include_tag) \
        .with('power').and_return('test3')

    includes = javascript_includes
    includes.should =~ /^test/
    includes.should =~ /test2/
    includes.should =~ /test3$/
  end
end

describe JavascriptHelper,
    'when outputting scripts through multiple invocations with extra arguments' do
  before(:each) do
    add_javascript 'test', :cache => false
    add_javascript 'test2', 'magic', :cache => 'power'
    add_javascript 'power', :cache => true
  end

   it 'should splat the arguments to javascript_include_tag each time ' +
      'and concatenate the results' do
    self.should_receive(:javascript_include_tag) \
        .with('test', :cache => false).and_return('test')
    self.should_receive(:javascript_include_tag) \
        .with('test2', 'magic', :cache => 'power').and_return('test2')
    self.should_receive(:javascript_include_tag) \
        .with('power', :cache => true).and_return('test3')

    includes = javascript_includes
    includes.should =~ /^test/
    includes.should =~ /test2/
    includes.should =~ /test3$/
   end
end

describe JavascriptHelper, 'when outputting with indentation and one item' do
  before(:each) do
    self.stub!(:javascript_include_tag).and_return("test\n")

    add_javascript 'test'
  end

  it 'should not indent the first line' do
    javascript_includes(:indent => 8).should =~ /^test/
  end

  it 'should not indent newlines with no text after them' do
    javascript_includes(:indent => 8).should =~ /\n$/m
  end
end

describe JavascriptHelper, 'when outputting with indentation and one item' do
  before(:each) do
    self.stub!(:javascript_include_tag).and_return("test\npower\n")

    add_javascript 'test', 'power'
  end

  it 'should not indent the first line' do
    javascript_includes(:indent => 8).should =~ /^test$/
  end

  it 'should indent newlines with text after them' do
    javascript_includes(:indent => 8).should =~ /^ {8}power$/
  end
end

describe JavascriptHelper, 'when outputting multiple scripts ' +
    'with no explicit indentation' do
  before(:each) do
    self.stub!(:javascript_include_tag).and_return("test\npower\n")

    add_javascript 'test', 'power'
  end

  it 'should indent with 4 spaces' do
    javascript_includes.should =~ /^ {4}power$/
  end
end

