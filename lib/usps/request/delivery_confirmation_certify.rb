module USPS::Request
  class DeliveryConfirmationCertify < USPS::Request::DeliveryConfirmation
    config(
      :api => 'DelivConfirmCertifyV4',
      :tag => 'DelivConfirmCertifyV4.0Request',
      :secure => true,
      :response => USPS::Response::DeliveryConfirmation
    )
  end
end
