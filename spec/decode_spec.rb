describe 'decode' do
  subject { |example| decode(example.description.sub(/given:? /, '')) }

  it 'given foo=bar&baz=buz' do |wat|
    should eq foo: 'bar', baz: 'buz'
  end

  it 'given Foo=bar' do |wat|
    should eq foo: 'bar'
  end

  it 'given fooFoo=bar' do |wat|
    should eq foo_foo: 'bar'
  end

  it 'given foo=bar&baz&buz' do |wat|
    should eq foo: 'bar'
  end

  it 'given foo=%2Bbar' do |wat|
    should eq foo: '+bar'
  end
end
