# frozen_string_literal: true

require 'rails_helper'

describe ServerConfigBuilder do
  subject { described_class.new(server: server) }

  let(:client_crt) do
    <<~TEXT
      Certificate:
          Data:
              Version: 3 (0x2)
              Serial Number: 2 (0x2)
          Signature Algorithm: sha256WithRSAEncryption
              Issuer: C=US, ST=CA, L=SanFrancisco, O=Fort-Funston, OU=MyOrganizationalUnit, CN=Fort-Funston CA/name=EasyRSA/emailAddress=me@myhost.mydomain
              Validity
                  Not Before: Jan 26 22:04:28 2019 GMT
                  Not After : Jan 23 22:04:28 2029 GMT
              Subject: C=US, ST=CA, L=SanFrancisco, O=Fort-Funston, OU=MyOrganizationalUnit, CN=generic_client/name=EasyRSA/emailAddress=me@myhost.mydomain
              Subject Public Key Info:
                  Public Key Algorithm: rsaEncryption
                      Public-Key: (2048 bit)
                      Modulus:
                          00:99:0a:dc:67:1e:be:44:4d:e4:8b:81:d1:8d:79:
                          78:b2:ac:40:33:a0:c3:7d:58:15:b6:4a:79:4c:2e:
                          49:51:59:93:a8:62:25:4a:3c:a1:6b:41:dd:a6:50:
                          42:48:e4:81:8f:ad:69:1a:e0:cc:19:c3:48:57:8f:
                          78:81:c4:b9:62:aa:16:41:81:a0:b4:b3:b1:32:ea:
                          ed:63:ae:f1:36:bc:1c:1f:f1:7e:d6:91:4c:8d:ce:
                          44:28:ce:2f:28:47:39:d3:18:af:a3:06:43:9c:5a:
                          9c:2d:72:74:63:e8:0b:5d:e6:f4:69:e1:35:44:35:
                          11:c3:9b:12:5e:6f:bf:ff:61:fe:e9:25:36:23:e4:
                          07:8a:36:f2:5b:89:ad:ff:68:5d:8c:64:64:3a:a0:
                          8f:b3:00:68:6f:2e:0f:33:97:dd:5a:bb:db:e4:1b:
                          da:c8:a1:92:1b:63:ad:ef:d5:0a:d6:03:b1:e9:47:
                          6b:1a:a7:66:8a:dc:5c:ec:34:13:26:23:a2:53:0b:
                          b7:ab:81:0e:33:01:05:a1:ba:7a:f5:ac:40:e2:6f:
                          71:03:e1:15:78:c1:fa:38:63:9a:9b:31:17:ba:ae:
                          cd:8d:48:c0:c2:c2:4f:be:9c:a0:e9:da:a1:3c:58:
                          fb:41:3b:5b:56:2b:d3:df:3b:17:f6:e0:8b:30:3d:
                          5d:43
                      Exponent: 65537 (0x10001)
              X509v3 extensions:
                  X509v3 Basic Constraints:
                      CA:FALSE
                  Netscape Comment:
                      Easy-RSA Generated Certificate
                  X509v3 Subject Key Identifier:
                      17:22:D1:25:1E:43:17:EB:C1:BC:15:8B:71:FD:3F:D7:1D:C5:51:6A
                  X509v3 Authority Key Identifier:
                      keyid:D2:E4:5E:A6:C1:BF:3C:B6:08:9F:F6:D4:03:01:65:DA:15:15:BB:05
                      DirName:/C=US/ST=CA/L=SanFrancisco/O=Fort-Funston/OU=MyOrganizationalUnit/CN=Fort-Funston CA/name=EasyRSA/emailAddress=me@myhost.mydomain
                      serial:DD:35:58:BD:F0:5D:98:97

                  X509v3 Extended Key Usage:
                      TLS Web Client Authentication
                  X509v3 Key Usage:
                      Digital Signature
                  X509v3 Subject Alternative Name:
                      DNS:generic_client
          Signature Algorithm: sha256WithRSAEncryption
               32:26:9c:f4:43:cf:24:1f:e0:0f:4b:e0:d8:cf:c9:90:63:db:
               c6:ab:cb:b5:43:d3:ed:f0:09:66:1b:15:9f:1f:ac:45:32:b3:
               5e:7b:fa:94:e0:cb:49:49:d3:31:c6:5a:c2:00:17:dd:46:0e:
               79:4a:bf:51:5f:e6:76:58:b6:20:8c:8e:fa:f2:58:57:b5:43:
               07:87:97:f2:38:3c:12:e7:32:74:db:41:fb:d4:42:d8:3b:31:
               a1:84:ca:72:dd:57:91:db:10:77:e3:c3:cd:e8:3d:30:d2:f5:
               a1:21:74:e1:26:5b:bc:ee:d9:29:8d:f7:51:98:e2:40:16:14:
               e1:d9:1f:c0:aa:18:09:83:c7:79:91:34:5c:79:c3:e3:b2:c4:
               48:62:70:01:f9:3f:af:f9:f7:4c:2c:0d:11:87:e5:fa:4e:15:
               36:c2:b8:c7:16:80:c7:fb:ea:21:1b:a2:43:ac:01:3a:81:ae:
               fe:85:c3:44:8c:74:ce:96:37:d6:33:97:55:ca:9b:8c:9b:9c:
               82:1a:ff:f7:6e:da:a7:a2:af:af:2c:fc:55:1c:47:65:99:95:
               1a:30:70:27:8d:cc:da:b0:cd:57:3e:0e:b4:70:85:19:dd:1b:
               83:e4:3d:5e:49:21:8c:b5:86:a4:bb:23:92:31:cb:e8:ac:05:
               b7:0b:37:fb
      -----BEGIN CERTIFICATE-----
      MIIFcjCCBFqgAwIBAgIBAjANBgkqhkiG9w0BAQsFADCBtjELMAkGA1UEBhMCVVMx
      CzAJBgNVBAgTAkNBMRUwEwYDVQQHEwxTYW5GcmFuY2lzY28xFTATBgNVBAoTDEZv
      cnQtRnVuc3RvbjEdMBsGA1UECxMUTXlPcmdhbml6YXRpb25hbFVuaXQxGDAWBgNV
      BAMTD0ZvcnQtRnVuc3RvbiBDQTEQMA4GA1UEKRMHRWFzeVJTQTEhMB8GCSqGSIb3
      DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTE5MDEyNjIyMDQyOFoXDTI5MDEy
      MzIyMDQyOFowgbUxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJDQTEVMBMGA1UEBxMM
      U2FuRnJhbmNpc2NvMRUwEwYDVQQKEwxGb3J0LUZ1bnN0b24xHTAbBgNVBAsTFE15
      T3JnYW5pemF0aW9uYWxVbml0MRcwFQYDVQQDFA5nZW5lcmljX2NsaWVudDEQMA4G
      A1UEKRMHRWFzeVJTQTEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWlu
      MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmQrcZx6+RE3ki4HRjXl4
      sqxAM6DDfVgVtkp5TC5JUVmTqGIlSjyha0HdplBCSOSBj61pGuDMGcNIV494gcS5
      YqoWQYGgtLOxMurtY67xNrwcH/F+1pFMjc5EKM4vKEc50xivowZDnFqcLXJ0Y+gL
      Xeb0aeE1RDURw5sSXm+//2H+6SU2I+QHijbyW4mt/2hdjGRkOqCPswBoby4PM5fd
      Wrvb5BvayKGSG2Ot79UK1gOx6UdrGqdmitxc7DQTJiOiUwu3q4EOMwEFobp69axA
      4m9xA+EVeMH6OGOamzEXuq7NjUjAwsJPvpyg6dqhPFj7QTtbVivT3zsX9uCLMD1d
      QwIDAQABo4IBiDCCAYQwCQYDVR0TBAIwADAtBglghkgBhvhCAQ0EIBYeRWFzeS1S
      U0EgR2VuZXJhdGVkIENlcnRpZmljYXRlMB0GA1UdDgQWBBQXItElHkMX68G8FYtx
      /T/XHcVRajCB6wYDVR0jBIHjMIHggBTS5F6mwb88tgif9tQDAWXaFRW7BaGBvKSB
      uTCBtjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRUwEwYDVQQHEwxTYW5GcmFu
      Y2lzY28xFTATBgNVBAoTDEZvcnQtRnVuc3RvbjEdMBsGA1UECxMUTXlPcmdhbml6
      YXRpb25hbFVuaXQxGDAWBgNVBAMTD0ZvcnQtRnVuc3RvbiBDQTEQMA4GA1UEKRMH
      RWFzeVJTQTEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluggkA3TVY
      vfBdmJcwEwYDVR0lBAwwCgYIKwYBBQUHAwIwCwYDVR0PBAQDAgeAMBkGA1UdEQQS
      MBCCDmdlbmVyaWNfY2xpZW50MA0GCSqGSIb3DQEBCwUAA4IBAQAyJpz0Q88kH+AP
      S+DYz8mQY9vGq8u1Q9Pt8AlmGxWfH6xFMrNee/qU4MtJSdMxxlrCABfdRg55Sr9R
      X+Z2WLYgjI768lhXtUMHh5fyODwS5zJ020H71ELYOzGhhMpy3VeR2xB348PN6D0w
      0vWhIXThJlu87tkpjfdRmOJAFhTh2R/AqhgJg8d5kTRcecPjssRIYnAB+T+v+fdM
      LA0Rh+X6ThU2wrjHFoDH++ohG6JDrAE6ga7+hcNEjHTOljfWM5dVypuMm5yCGv/3
      btqnoq+vLPxVHEdlmZUaMHAnjczasM1XPg60cIUZ3RuD5D1eSSGMtYakuyOSMcvo
      rAW3Czf7
      -----END CERTIFICATE-----

    TEXT
  end
  let(:result_config) do
    <<~TEXT
      client

      dev tun

      proto udp

      remote localhost 443

      resolv-retry infinite
      nobind
      persist-key
      persist-tun
      reneg-sec 0

      auth-user-pass
      comp-lzo

      <ca>
      Some super CA key
      </ca>

      <cert>
      -----BEGIN CERTIFICATE-----
      MIIFcjCCBFqgAwIBAgIBAjANBgkqhkiG9w0BAQsFADCBtjELMAkGA1UEBhMCVVMx
      CzAJBgNVBAgTAkNBMRUwEwYDVQQHEwxTYW5GcmFuY2lzY28xFTATBgNVBAoTDEZv
      cnQtRnVuc3RvbjEdMBsGA1UECxMUTXlPcmdhbml6YXRpb25hbFVuaXQxGDAWBgNV
      BAMTD0ZvcnQtRnVuc3RvbiBDQTEQMA4GA1UEKRMHRWFzeVJTQTEhMB8GCSqGSIb3
      DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTE5MDEyNjIyMDQyOFoXDTI5MDEy
      MzIyMDQyOFowgbUxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJDQTEVMBMGA1UEBxMM
      U2FuRnJhbmNpc2NvMRUwEwYDVQQKEwxGb3J0LUZ1bnN0b24xHTAbBgNVBAsTFE15
      T3JnYW5pemF0aW9uYWxVbml0MRcwFQYDVQQDFA5nZW5lcmljX2NsaWVudDEQMA4G
      A1UEKRMHRWFzeVJTQTEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWlu
      MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmQrcZx6+RE3ki4HRjXl4
      sqxAM6DDfVgVtkp5TC5JUVmTqGIlSjyha0HdplBCSOSBj61pGuDMGcNIV494gcS5
      YqoWQYGgtLOxMurtY67xNrwcH/F+1pFMjc5EKM4vKEc50xivowZDnFqcLXJ0Y+gL
      Xeb0aeE1RDURw5sSXm+//2H+6SU2I+QHijbyW4mt/2hdjGRkOqCPswBoby4PM5fd
      Wrvb5BvayKGSG2Ot79UK1gOx6UdrGqdmitxc7DQTJiOiUwu3q4EOMwEFobp69axA
      4m9xA+EVeMH6OGOamzEXuq7NjUjAwsJPvpyg6dqhPFj7QTtbVivT3zsX9uCLMD1d
      QwIDAQABo4IBiDCCAYQwCQYDVR0TBAIwADAtBglghkgBhvhCAQ0EIBYeRWFzeS1S
      U0EgR2VuZXJhdGVkIENlcnRpZmljYXRlMB0GA1UdDgQWBBQXItElHkMX68G8FYtx
      /T/XHcVRajCB6wYDVR0jBIHjMIHggBTS5F6mwb88tgif9tQDAWXaFRW7BaGBvKSB
      uTCBtjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRUwEwYDVQQHEwxTYW5GcmFu
      Y2lzY28xFTATBgNVBAoTDEZvcnQtRnVuc3RvbjEdMBsGA1UECxMUTXlPcmdhbml6
      YXRpb25hbFVuaXQxGDAWBgNVBAMTD0ZvcnQtRnVuc3RvbiBDQTEQMA4GA1UEKRMH
      RWFzeVJTQTEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluggkA3TVY
      vfBdmJcwEwYDVR0lBAwwCgYIKwYBBQUHAwIwCwYDVR0PBAQDAgeAMBkGA1UdEQQS
      MBCCDmdlbmVyaWNfY2xpZW50MA0GCSqGSIb3DQEBCwUAA4IBAQAyJpz0Q88kH+AP
      S+DYz8mQY9vGq8u1Q9Pt8AlmGxWfH6xFMrNee/qU4MtJSdMxxlrCABfdRg55Sr9R
      X+Z2WLYgjI768lhXtUMHh5fyODwS5zJ020H71ELYOzGhhMpy3VeR2xB348PN6D0w
      0vWhIXThJlu87tkpjfdRmOJAFhTh2R/AqhgJg8d5kTRcecPjssRIYnAB+T+v+fdM
      LA0Rh+X6ThU2wrjHFoDH++ohG6JDrAE6ga7+hcNEjHTOljfWM5dVypuMm5yCGv/3
      btqnoq+vLPxVHEdlmZUaMHAnjczasM1XPg60cIUZ3RuD5D1eSSGMtYakuyOSMcvo
      rAW3Czf7
      -----END CERTIFICATE-----
      </cert>

      <key>
      The best client key ever
      </key>
    TEXT
  end
  let(:ca_crt) { 'Some super CA key' }
  let(:client_key) { 'The best client key ever' }
  let(:server) do
    create(:server,
           hostname: 'localhost',
           client_crt: client_crt,
           server_crt: ca_crt,
           client_key: client_key)
  end

  describe '#to_text' do
    it 'returns expected config' do
      expect(subject.to_text).to eq result_config
    end

    it 'returns ServerConfig text' do
      expect(subject.to_text.class).to eq String
    end

    describe 'protocol' do
      it 'contains protocol' do
        expect(subject.to_text).to include server.protocol
      end

      it 'replaces old protocol' do
        expect(subject.to_text).not_to include 'unknown_proto'
      end
    end

    describe 'host' do
      it 'contains host' do
        expect(subject.to_text).to include server.hostname
      end

      it 'replaces old host' do
        expect(subject.to_text).not_to include 'unknown_host'
      end
    end

    describe 'port' do
      it 'contains port' do
        expect(subject.to_text).to include server.port.to_s
      end

      it 'replaces old port' do
        expect(subject.to_text).not_to include 'unknown_port'
      end
    end

    describe 'client_crt' do
      it 'does not contain certificate information' do
        expect(subject.to_text).not_to include 'Signature Algorithm: sha256WithRSAEncryption'
      end
    end
  end
end
