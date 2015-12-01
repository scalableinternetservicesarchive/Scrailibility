#encoding:utf-8
#Originally created by Leon <i@leons.im> in 2012
#Modified by Calvin <https://github.com/thecalvinchan> in 2015

import urllib2
import re, json, time,hashlib, random
import MultipartPostHandler
from urllib2 import URLError, HTTPError


def get_address():
    u = 1000000.0
    v = 10000000.0

    # Uses lat, lng of UCLA
    latitude = int(random.gauss(340689210, u))
    longitude = int(random.gauss(-1184473751, u))
    # print "longitude=%d,latitude=%d" % (longitude, latitude)

    url = 'http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=false' % (latitude/v, longitude/v)
    # print url
    opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(), urllib2.HTTPRedirectHandler())

    try:
        str_content = opener.open(url).read()
    except HTTPError, e:
        # print 'Error code: ', e.code
        time.sleep(36)
        return get_address()
    except URLError, e:
        # print e.reason
        time.sleep(36)
        return get_address()

    if str_content:
        content = json.loads(str_content)
        if content['status'] == 'OK':
            for results in content['results']:
                address = results['formatted_address']
                address = address.encode('utf-8')
                print '{:longitude => %s, :latitude => %s, :address => \'%s\'},' % (results['geometry']['location']['lng'], results['geometry']['location']['lat'], address)
            return True
        else:
            # This is due to the 2500/24h limit.
            return False

def main():
    while get_address():
        continue
    return True

if __name__ == "__main__":
    main()
