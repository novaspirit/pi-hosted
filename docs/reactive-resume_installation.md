## Reactive Resume installation
* Please run [install_reactive-resume.sh](https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/tools/install_reactive-resume.sh) before continuing installation

### ENV descriptions
This description stripped down from [official-docs](https://github.com/AmruthPillai/Reactive-Resume/blob/2f6072a7ba66d77a1f6682d70367f87323f2d70f/docs/docs/source-code/env-vars.mdx) as not everything used by this image.

#### `TZ`
* Required: `no`  
* Default Value: `UTC`  
* Description: Server Timezone

#### `SECRET_KEY`
* Required*: `yes`  
* Description: Secret Key for Client-Server Communication, the secret key can be a unique key, a randomly generated string that is used for client-server communication. You can use this [random.org](https://www.random.org/strings/?num=10&len=20&digits=on&upperalpha=on&loweralpha=on&unique=on&format=html&rnd=new) configuration to generate a long unique string.

#### `DATABASE_USERNAME`
* Required: `yes`  
* Default Value: `reactiveresume`  
* Description: Username of the PostgreSQL Server

#### `DATABASE_PASSWORD`
* Required: `yes`  
* Default Value: `reactiveresume`  
* Description: Password of the PostgreSQL Server

#### `JWT_SECRET`
* Required: `yes`  
* Description: Secret to Sign and Extract JWT Payloads, Similar to the `SECRET_KEY`, this can also be a unique generated string. This is used for email/password authentication, to hash + salt passwords stored in the database so they are unreadable.

#### `GOOGLE_API_KEY`
* Required: `no`  
* Description: Google API Key used for fetching Google Fonts, within the resume builder, there's a section where you can pick any font from the Google Fonts Library. To fetch the names and IDs of these fonts, we depend on the Google Fonts API. It does not cost any payment, or the need to enter credit card information to create or use this API. You can get your own key here: [Google Webfonts API](https://developers.google.com/fonts/docs/developer_api). If you do not have a Google API Key, it was make use of the cached response JSON that's stored within the project source. Please note that this cache is not updated and may not have all the latest fonts that Google Fonts has to offer.

#### `PUBLIC URL`
* Required: `yes`
* The URL where the web facing
* Sample: http://ipaddress:port or https://somepublic.domain.tld

#### `PUBLIC_SERVER_URL`
* Required:`yes`
* The URL where server processing
* Sample: http://ipaddress:port or https://somepublicserver.domain.tld
