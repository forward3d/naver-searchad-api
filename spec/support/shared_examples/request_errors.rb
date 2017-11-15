RSpec.shared_examples 'not enough permission request' do
  it 'raises NotEnoughPermissionError error' do
    expect{ request }.to raise_error(NotEnoughPermissionError)
  end
end

RSpec.shared_examples 'error in request' do
  it 'raises RequestError error' do
    expect{ request }.to raise_error(RequestError)
  end
end

RSpec.shared_examples 'invalid request' do
  it 'raises InvalidRequestError error' do
    expect{ request }.to raise_error(InvalidRequestError)
  end
end
