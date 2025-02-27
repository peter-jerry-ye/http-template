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
  request : @types.IncomingRequest,
  response_out : @types.ResponseOutparam
) -> Unit {
  @promise.spawn(async fn(_defer) {
    try {
      top!!(request, response_out)
    } catch {
      error => @io.println("Error \{error}", stream=@io.stderr).await!!()
    }
  })
  |> ignore
  @io.event_loop.run()
}

///|
async fn top(
  _request : @types.IncomingRequest,
  response_out : @types.ResponseOutparam
) -> Unit! {
  let response = @types.OutgoingResponse::outgoing_response(@http.headers({}))
  response.set_status_code(200).unwrap()
  let outgoing_body = response.body().unwrap()
  response_out.set(Ok(response))
  let outgoing_stream = outgoing_body.write().unwrap()
  @io.println("Hello World!", stream=outgoing_stream).await!!()
  outgoing_stream.drop()
  outgoing_body.finish(None).unwrap_or_error!()
}
