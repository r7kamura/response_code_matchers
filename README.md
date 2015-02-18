# ResponseCodeMatchers

Provide rspec matchers to match http response code.  
The receiver of this matcher should have `#code` or `#status` method which returns http status code,
 and `#header` and `#headers` methods.

## Installation
```
$ gem install response_code_matchers
```

## Usage
In Rails example:

```ruby
# spec/spec_helper.rb
require "response_code_matchers"

RSpec.configure do |config|
  config.include ResponseCodeMatchers
end
```

```ruby
# spec/controllers/blogs_controller.rb
describe BlogsController do
  describe "#create" do
    subject do
      post :create, params
    end

    let(:params) do
      { :title => "title", :body => "body", :token => "token", :user_id => 1 }
    end

    # 201
    context "with valid token" do
      it { should be_created }
    end

    # 400
    context "without user_id" do
      before do
        params.delete(:user_id)
      end

      it { should be_bad_request }
    end

    # 401
    context "with invalid token" do
      before do
        params[:token] = "invalid"
      end

      it { should be_unauthorized }
    end
  end
end
```


## Advantage
[Rack::Response](https://github.com/rack/rack/blob/master/lib/rack/response.rb) has predicative methods like `#not_found?`, `#bad_request?`, and etc. so we can use `response.should be_not_found` without this gem.

There are 2 advantages to use this gem.

1. The range of differences that Rack::Response does not have
2. Useful failure messages for each failed reason

```
# without response_code_matchers.gem
expected not_found? to return true, got false

# with response_code_matchers.gem
expected response code to be 404, but 400
```


## Matchers
```ruby
100: response.should be_continue
101: response.should be_switching_protocols
102: response.should be_processing
200: response.should be_ok
201: response.should be_created
202: response.should be_accepted
203: response.should be_non_authoritative_information
204: response.should be_no_content
205: response.should be_reset_content
206: response.should be_partial_content
207: response.should be_multi_status
226: response.should be_im_used
300: response.should be_multiple_choices
301: response.should be_moved_permanently
302: response.should be_found
303: response.should be_see_other
304: response.should be_not_modified
305: response.should be_use_proxy
307: response.should be_temporary_redirect
400: response.should be_bad_request
401: response.should be_unauthorized
402: response.should be_payment_required
403: response.should be_forbidden
404: response.should be_not_found
405: response.should be_method_not_allowed
406: response.should be_not_acceptable
407: response.should be_proxy_authentication_required
408: response.should be_request_timeout
409: response.should be_conflict
410: response.should be_gone
411: response.should be_length_required
412: response.should be_precondition_failed
413: response.should be_payload_too_large
414: response.should be_uri_too_long
415: response.should be_unsupported_media_type
416: response.should be_range_not_satisfiable
417: response.should be_expectation_failed
418: response.should be_im_a_teapot
422: response.should be_unprocessable_entity
423: response.should be_locked
424: response.should be_failed_dependency
426: response.should be_upgrade_required
500: response.should be_internal_server_error
501: response.should be_not_implemented
502: response.should be_bad_gateway
503: response.should be_service_unavailable
504: response.should be_gateway_timeout
505: response.should be_http_version_not_supported
506: response.should be_variant_also_negotiates
507: response.should be_insufficient_storage
510: response.should be_not_extended
```
