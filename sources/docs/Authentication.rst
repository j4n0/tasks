
Authentication
==============

To start using the API in your project you need either an API key or an authentication token.

Get an API key
--------------

1. Log to your project using the details provided in the specification page.
2. Go to your profile (top, right), and click on “Edit My Details”.
3. Go to the tab API & Mobile. Click Show your Token. For me, it was ``twp_k9ejP88LcuojHjmFkUFuYIUNYalg`` (yours will be different).

Get an authentication token
---------------------------

The page `How to Authenticate via App Login Flow  <https://developer.teamwork.com/projects/authentication-questions/how-to-authenticate-via-app-login-flow>`_ explains the steps, which are as follow:

1. Open https://www.teamwork.com/launchpad/login?redirect_uri=customprotocolapp://whatever in a webview.
2. Fill the login and password in the form that appears.
3. Once logged the page will redirect to the ``customprotocolapp://whatever`` you passed before, and an authentication token will be added. You need to capture this code. In iOS you can do so intercepting the call, for instance, in a `WKNavigationDelegate <https://developer.apple.com/documentation/webkit/wknavigationdelegate>`_.
4. Once you have the code, run a HTTP POST to https://www.teamwork.com/launchpad/v1/token.json with body ``{"code":"BANANAS"}`` where *BANANAS* is the authentication code we got in the previous step. 

My access token response was:

.. literalinclude:: token.json
   :language: json

5. Store the access_token and submit further API requests to the API URL with header ``Authorization: Bearer CAFEBABE`` where *CAFEBABE* is the access token you got in the previous step.


Curl with API key
-----------------

Use the following API call format:

- The API base URL is https://ACCOUNT.teamwork.com. According to `this <https://developer.teamwork.com/projects/finding-your-url-and-api-key/api-key-and-url>`_ it’s on your project website at profile > Settings > General tab > Site Address.
- The API path is one documented in the API reference. For instance, for `Retrieve All Projects <https://developer.teamwork.com/projects/projects/retrieve-all-projects>`_ is ``/projects.json``.
- Add a header ``Accept: application/json``. Just being pedantic, you still get a JSON without it because curl issues an ``Accept: */*`` by default.
- Add a header ``Authorization: BASIC CAFEBABE``, replacing CAFEBABE with your API key encoded in base64. Why base 64? it says so in `RFC7617 <http://www.rfc-editor.org/rfc/rfc7617.txt>`_.

Let’s try this for the account “yat” and the endpoint `/projects.json <https://developer.teamwork.com/projects/projects/retrieve-all-projects>`_::

    curl -s -H "Accept: application/json" -H "Authorization: BASIC `echo -n twp_k9ejP88LcuojHjmFkUFuYIUNYalg | base64`" https://yat.teamwork.com/projects.json | python -mjson.tool

Note that the ``echo -n`` avoids passing an extra new line character.

Curl with authentication token
------------------------------

Open ``https://www.teamwork.com/launchpad/login?redirect_uri=customprotocolapp://whatever`` in your browser, login, and copy the resulting code. It will be something like customprotocolapp://whatever?code=13fb3653-669b-45ca-a710-b06e239b85d3. If you want to see the page, it’s just a bunch of JS references.
::

    curl -s https://www.teamwork.com/launchpad/login?redirect_uri=customprotocolapp://whatever | tidy

Now post it:
::

    curl -s -X POST -H "Accept: application/json" -H "Content-Type: application/json" -d '{"code":"13fb3653-669b-45ca-a710-b06e239b85d3"}' https://www.teamwork.com/launchpad/v1/token.json | python -mjson.tool

My token was ``tkn.v1_MThiNDkzNTUtNmI5MS00NmIyLThhYmQtOWYxNTdjNTBjYWFkLTM0OTcwNS4yMzA5MDcuVVM=``. Use it to read the projects.
::

    curl -v -H "Accept: application/json" -H "Authorization: Bearer tkn.v1_MThiNDkzNTUtNmI5MS00NmIyLThhYmQtOWYxNTdjNTBjYWFkLTM0OTcwNS4yMzA5MDcuVVM=" https://yat.teamwork.com/projects.json | python -mjson.tool



