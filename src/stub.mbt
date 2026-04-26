///|
/// This function is invoked with an incoming HTTP Request, and a resource
/// `response-outparam` which provides the capability to reply with an HTTP
/// Response. The response is sent by calling the `response-outparam.set`
/// method, which allows execution to continue after the response has been
/// sent. This enables both streaming to the response body, and performing other
/// work.
///
/// The implementor of this function must write a response to the
/// `response-outparam` before returning, or else the caller will respond
/// with an error on its behalf.
pub fn handle(
  _request : @types.IncomingRequest,
  response_out : @types.ResponseOutparam,
) -> Unit {
  let response = @types.OutgoingResponse::outgoing_response(
    @types.Fields::fields(),
  )
  ignore(response.set_status_code(200U))
  let outgoing_body = response.body().unwrap()
  response_out.set(Ok(response))
  let outgoing_stream = outgoing_body.write().unwrap()
  ignore(
    outgoing_stream.blocking_write_and_flush(b"Hello World!".to_fixedarray()),
  )
  outgoing_stream.drop()
  ignore(outgoing_body.finish(None))
}
