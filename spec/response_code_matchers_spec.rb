require "spec_helper"

describe ResponseCodeMatchers do
  %w[
    100 be_continue
    101 be_switching_protocols
    102 be_processing
    200 be_ok
    201 be_created
    202 be_accepted
    203 be_non_authoritative_information
    204 be_no_content
    205 be_reset_content
    206 be_partial_content
    207 be_multi_status
    226 be_im_used
    300 be_multiple_choices
    301 be_moved_permanently
    302 be_found
    303 be_see_other
    304 be_not_modified
    305 be_use_proxy
    306 be_reserved
    307 be_temporary_redirect
    400 be_bad_request
    401 be_unauthorized
    402 be_payment_required
    403 be_forbidden
    404 be_not_found
    405 be_method_not_allowed
    406 be_not_acceptable
    407 be_proxy_authentication_required
    408 be_request_timeout
    409 be_conflict
    410 be_gone
    411 be_length_required
    412 be_precondition_failed
    413 be_request_entity_too_large
    414 be_request_uri_too_long
    415 be_unsupported_media_type
    416 be_requested_range_not_satisfiable
    417 be_expectation_failed
    422 be_unprocessable_entity
    423 be_locked
    424 be_failed_dependency
    426 be_upgrade_required
    500 be_internal_server_error
    501 be_not_implemented
    502 be_bad_gateway
    503 be_service_unavailable
    504 be_gateway_timeout
    505 be_http_version_not_supported
    506 be_variant_also_negotiates
    507 be_insufficient_storage
    510 be_not_extended
  ].each_slice(2) do |code, matcher|
    describe "##{matcher}" do
      let(:response) do
        double(:code => code)
      end

      it "matches http response code #{code}" do
        expect(response).to send(matcher)
      end
    end
  end

  context "when receiver responds to #status" do
    let(:receiver) do
      double(:status => 406)
    end

    it "calls original receiver.xxx?" do
      expect(receiver).to be_not_acceptable
    end
  end

  context "when receiver does not have a method #code" do
    let(:receiver) do
      double(:accepted? => true)
    end

    it "calls original receiver.xxx?" do
      expect(receiver).to be_accepted
    end
  end
end
