json.conversations do
  json.array!(@conversations, partial: 'conversation', as: :conversation)
end
