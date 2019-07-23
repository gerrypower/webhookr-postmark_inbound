class PostmarkInboundHooks

  # All 'on_' handlers are optional. Omit any you do not require.

  def on_email(incoming)
    payload = incoming.payload
    puts("email: #{payload.msg.email}")
  end
end