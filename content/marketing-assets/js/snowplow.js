(function() {
  // Set this constant depending on if this is a dev environment or production
  // hardcoding to true for now
  const isProduction = true;
  const SNOWPLOW_URL = isProduction
    ? 'https://assets.getpocket.com/web-utilities/public/static/te.js'
    : 'https://assets.getpocket.com/web-utilities/public/static/sp.js';
  function getUserData () {
    const data = {
      hashed_user_id: Mozilla.Cookies.getItem('a95b4b6'),
      hashed_guid: Mozilla.Cookies.getItem('sess_guid')
    };
    Object.keys(data).forEach(key => {
      if (data[key] === null) {
        delete data[key];
      }
    });
    if (Object.keys(data).length) {
      return data;
    } else {
      return null;
    }
  }
  // script is provided by Snowplow
  (function(p,l,o,w,i,n,g){if(!p[i]){p.GlobalSnowplowNamespace=p.GlobalSnowplowNamespace||[];
    p.GlobalSnowplowNamespace.push(i);p[i]=function(){(p[i].q=p[i].q||[]).push(arguments)
    };p[i].q=p[i].q||[];n=l.createElement(o);g=l.getElementsByTagName(o)[0];n.async=1;
    n.src=w;g.parentNode.insertBefore(n,g)}})(window,document,"script",SNOWPLOW_URL,"snowplow");
  const connectorUrl = isProduction
    ? 'd.getpocket.com'
    : 'com-getpocket-prod1.mini.snplow.net';
  const appId = isProduction
    ? 'pocket-web-mktg'
    : 'pocket-web-mktg-dev';
  snowplow('newTracker', 'sp', connectorUrl, {
    appId,
    platform: 'web',
    eventMethod: 'beacon',
    respectDoNotTrack: false,
    contexts: {
      webPage: true,
      performanceTiming: true
    }
  });
  const data = getUserData();
  if (data) {
    snowplow('addGlobalContexts', [{
      schema: `iglu:com.pocket/user/jsonschema/1-0-0`,
      data
    }]);
  }
  snowplow(
    'enableActivityTracking',
    10, // heartbeat delay
    10 // heartbeat interval
  );
  snowplow('enableLinkClickTracking');
  snowplow('enableFormTracking');
  snowplow('trackPageView');
})();
