'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "c3c36050baa83731fdc1e597150aebf1",
"/": "c3c36050baa83731fdc1e597150aebf1",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icon_launcher.png": "a571dfb0fa575999bd76621d2c9643c2",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"main.dart.js": "9327ab97588e5b9893f7587b1a29e318",
"logo.png": "e1e078a51ace5c773d0ae05bc8622c17",
"version.json": "b05425c51d0838c2cc7bb637cbea85c3",
"manifest.json": "7af2de7af15b4d15636ec6eb93853ea9",
"assets/images/barley.png": "0f223f8393f22436818253909ef7bb74",
"assets/images/sld_qr.png": "a9d3bd1966e4244d2a39d2d4fb274a2a",
"assets/images/fruits.png": "b79ae45904e97486168364fe11a49e0f",
"assets/images/undraw_Mobile_application.svg": "3132cc89f42c33810c5297723c2654ba",
"assets/images/vegetable.png": "439c54f068aed285da7449f50e73b0e6",
"assets/images/undraw_loving_it.svg": "84d5841ec3be154a1c820a331ae00840",
"assets/images/facebook.jpg": "e78b8801fec15b36530841424b13057d",
"assets/images/icon_launcher.png": "a571dfb0fa575999bd76621d2c9643c2",
"assets/images/undraw_wallet.svg": "0e8afb5c697b412bf2b8b61f3ba0640d",
"assets/images/icons/add_image.svg": "ca513b22a90198d8bb37d049898785b1",
"assets/images/icons/contact.svg": "b36cb7ffafb70d0727843f4eb256cae2",
"assets/images/icons/sld_qr.svg": "f95a5620a1f913cbceffe403e6578746",
"assets/images/icons/form.svg": "ab5e289ea783adceb8e1f65be5d2d494",
"assets/images/logo.png": "e1e078a51ace5c773d0ae05bc8622c17",
"assets/images/others.png": "d1d6dea5c49801220474d50bfc60dff4",
"assets/images/eco-car.png": "36b73dce45e1786a3643f00e5818e5a4",
"assets/images/fish.png": "b6b0f6c1e65d5ee0dab1cc6fe947e5ea",
"assets/images/google.jpg": "d0991539b51f1520c42d1dee04ba0faa",
"assets/images/confirm_product.svg": "753e09fe445f080fb6391894f7890882",
"assets/images/sld_qr.svg": "0aefc5e6fa7f913282206d3dc39cddfa",
"assets/images/maker_dai.png": "1b9b8867cce5534f5b6d9561625f73b4",
"assets/images/undraw_empty_cart.svg": "5d005a6dd55a006be829997b0f4e2c65",
"assets/images/pin_location.svg": "584485ac7879f5ed77336ea567b01679",
"assets/images/packaging.svg": "c31ba45f8e4fc5e37cd32fafb11d831e",
"assets/images/loading.gif": "baeaf0c7f02777839e58eed62cc714c4",
"assets/images/animation/check.flr": "c7150adb17a1a0624aaa0f72be2455cf",
"assets/images/animation/splash_screen.flr": "affc552bcb21b17753153976a66e6345",
"assets/images/animation/fabs.flr": "0249cecee5877a10d45fe9c77108be0c",
"assets/images/avatar.png": "bd293174ad01f0f72d407f3f2847f576",
"assets/images/etherium.jpg": "9910cc35043180fa6d408afa7599c86e",
"assets/images/meat.png": "a56ada69886bb2516fbba67580157da3",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/NOTICES": "0e21d9aa7ad54d620d3169eb39de6b8b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/lang/km.json": "1c773757280ae4016160b1acdada0df1",
"assets/lang/en.json": "db76ae2c5260cb7d5f9a65ff7b7a40a1",
"assets/AssetManifest.json": "bd0857ed837d5d62bc7b6220f30a8905",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
