describe 'parse' do
  subject { |example| parse(example.description.sub(/given:? /, '')) }

  it 'given: ja' do
    should eq service: true
  end

  it 'given: Ja' do
    should eq service: true
  end

  it 'given: JA' do
    should eq service: true
  end

  it 'given: yes' do
    should eq service: true
  end

  it 'given: ok' do
    should eq service: true
  end

  it 'given: fährt' do
    should eq service: true
  end

  it 'given: Fährt' do
    should eq service: true
  end

  it 'given: faehrt' do
    should eq service: true
  end

  it 'given: Faehrt' do
    should eq service: true
  end

  it 'given: allesklar' do
    should eq service: true
  end

  it 'given: nein' do
    should eq service: false
  end

  it 'given: faehrtnicht' do
    should eq service: false
  end

  it 'given: Faehrtnicht' do
    should eq service: false
  end
end
