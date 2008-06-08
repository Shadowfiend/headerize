require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../lib/headerize/stylesheet_helper.rb'

include Headerize

describe StylesheetHelper, 'when including a single file' do
  it 'should reutrn nothing' do
    add_stylesheet('test').should be_nil
  end
end

describe StylesheetHelper, 'when including multiple files' do
  it 'should return nothing' do
    add_stylesheet('test', 'second_test', 'magic').should be_nil
  end
end

describe StylesheetHelper, 'when passing extra arguments to add_stylesheet' do
  it 'should return nothing' do
    add_stylesheet('test', 'magic', :media => 'print').should be_nil
  end
end

describe StylesheetHelper, 'when outputting stylesheets without files' do
  it 'should return an empty string' do
    stylesheet_links.should be_empty
  end
end

describe StylesheetHelper, 'when outputting with indentation ' +
    'but no stylesheets' do
  it 'should return an empty string' do
    stylesheet_links(:indent => 8).should be_empty
  end
end

describe StylesheetHelper, 'when outputting stylesheets with a single file' do
  before(:each) do
    add_stylesheet 'test'
  end

  it 'should use stylesheet_link_tag to include it' do
    self.should_receive(:stylesheet_link_tag).with('test').and_return('test')

    stylesheet_links.should == 'test'
  end
end

describe StylesheetHelper,
    'when outputting stylesheets with multiple add_stylesheet arguments' do
  before(:each) do
    add_stylesheet 'test', 'magic', :media => 'print'
  end

  it 'should splat the arguments to the stylesheet_link_tag' do
    self.should_receive(:stylesheet_link_tag) \
        .with('test', 'magic', :media => 'print').and_return('test')

    stylesheet_links.should == 'test'
  end
end

describe StylesheetHelper,
    'when outputting stylesheets through multiple invocations' do
  before(:each) do
    add_stylesheet 'test'
    add_stylesheet 'test2', 'magic'
    add_stylesheet 'power'
  end

  it 'should call stylesheet_link_tag for each set ' +
     'and concatenate the results' do
    self.should_receive(:stylesheet_link_tag) \
        .with('test').and_return('test')
    self.should_receive(:stylesheet_link_tag) \
        .with('test2', 'magic').and_return('test2')
    self.should_receive(:stylesheet_link_tag) \
        .with('power').and_return('test3')

    links = stylesheet_links
    links.should =~ /^test/
    links.should =~ /test2/
    links.should =~ /test3$/
  end
end

describe StylesheetHelper,
    'when outputting stylesheets through multiple invocations ' +
    'with extra arguments' do
  before(:each) do
    add_stylesheet 'test', :media => 'print'
    add_stylesheet 'test2', 'magic', :media => 'print'
    add_stylesheet 'power', :cache => true
  end

  it 'should splat the arguments to stylesheet_link_tag each time ' +
     'and concatenate the results' do
    self.should_receive(:stylesheet_link_tag) \
        .with('test', :media => 'print').and_return('test')
    self.should_receive(:stylesheet_link_tag) \
        .with('test2', 'magic', :media => 'print').and_return('test2')
    self.should_receive(:stylesheet_link_tag) \
        .with('power', :cache => true).and_return('test3')

    links = stylesheet_links
    links.should =~ /^test/
    links.should =~ /test2/
    links.should =~ /test3$/
  end
end

describe StylesheetHelper, 'when outputting with indentation and one item' do
  before(:each) do
    self.stub!(:stylesheet_link_tag).and_return("test\n")

    add_stylesheet 'test'
  end

  it 'should not indent the first line' do
    stylesheet_links(:indent => 8).should =~ /^test/
  end

  it 'should not indent newlines with no text after them' do
    stylesheet_links(:indent => 8).should =~ /\n$/m
  end
end

describe StylesheetHelper, 'when outputting with indentation and one item' do
  before(:each) do
    self.stub!(:stylesheet_link_tag).and_return("test\npower\n")

    add_stylesheet 'test', 'power'
  end

  it 'should not indent the first line' do
    stylesheet_links(:indent => 8).should =~ /^test$/
  end

  it 'should indent newlines with text after them' do
    stylesheet_links(:indent => 8).should =~ /^ {8}power$/
  end
end

describe StylesheetHelper, 'when outputting multiple stylesheets ' +
    'with no explicit indentation' do
  before(:each) do
    self.stub!(:stylesheet_link_tag).and_return("test\npower\n")

    add_stylesheet 'test', 'power'
  end

  it 'should indent with 4 spaces' do
    stylesheet_links.should =~ /^ {4}power$/
  end
end

