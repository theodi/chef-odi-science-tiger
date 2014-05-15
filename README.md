[![Dependency Status](http://img.shields.io/gemnasium/theodi/chef-odi-science-tiger.svg)](https://gemnasium.com/theodi/chef-odi-science-tiger)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://theodi.mit-license.org)
[![Badges](http://img.shields.io/:badges-3/3-ff6799.svg)](https://github.com/badges/badgerbadgerbadger)

#Science Tiger

![Dashboards in the ODI office](https://i.imgflip.com/8t5qu.jpg)

We have [dashboards](https://github.com/theodi/dashboards/). We have [Raspberry Pis](http://www.raspberrypi.org/). We have four big-screen TVs. If only there was some way we could bring these things together...

We previously had a single Pi running just the [Tech Team Dashboard](http://dashboards.theodi.org/tech) on a single screen, but it had been lashed together with chewing-gum and string and was a terrible [snowflake](http://martinfowler.com/bliki/SnowflakeServer.html). If we want multiple displays, we need some ROBOTS!

##So what's in here?

This is a pretty simple Chef cookbook that will build and manage a set of Pis, each of which will boot into [Midori](http://midori-browser.org/) (by default) in kiosk-mode, showing a single URL

##How to use it

It relies upon another git repo: by default, it will use our [display-screen-content](https://github.com/theodi/display-screen-content) but it's unlikely you're going to want to put our dashboards on your screens. So create your repo thus:

* a CSV file named for each of your nodes, containing
* a single line, containing
* a single field, _viz_. the URL you'd like to show on that node
* except...

###The Huboard problem

Because REASONS, [Huboard](https://huboard.com/) does not work at all on out-of-the-box Midori on Raspbian, and I expect other sites will be similarly afflicted. So you can add a second field to those CSVs to specify a browser - at the moment only Chromium is supported, and it's parsed with [this horror-show](https://github.com/theodi/chef-odi-science-tiger/blob/master/templates/default/runbrowser.erb), but it's working for us. YMMV

Whatever, set your new repo as the __node['content_repo']__ attribute

##Bootstrapping

So how to actually get this running on a Pi? I've spent so long firing up Rackspace Cloud nodes with Vagrant, I'd forgotten how to `knife bootstrap`...

###NOOBS

The recommended way to get Raspbian onto an SD card these days is with [NOOBS](http://www.raspberrypi.org/introducing-the-new-out-of-box-software-noobs/), so download that and stick it on yer SD card, then boot the Pi with it (having first connected a screen, a mouse-and-keyboard, and a network cable). Choose Raspbian and let it do its thing, then at the red menu choose the thing that says something like 'Boot into GUI' (can't remember the exact words). It will reboot again, then it should log you in automatically. Open a terminal and run `ifconfig`, because you're going to need the IP address for the next step

###Knife

Presuming you have [`knife`](http://docs.opscode.com/knife.html) configured to talk to your Chef server, the next step should be as simple as:

    PI_IP=whatever.you.got.above
    NODENAME=naming-things-is-hard-01
    knife bootstrap ${PI_IP} -x pi -P raspberry -d raspbian -N ${NODENAME} -r 'recipe[odi-science-tiger]' --sudo

(or however you do this kind of thing with _chef-solo_ or _chef-zero_) and you should have a working node - you'll need to reboot it at the end of the run to get it to pick up all the changes, but from then it will be in the hands of the Chef robots

##Changing the content

You want to show a different URL? No problem. In whatever you're using for _content_repo_, change the CSV file for the node and push to master. On the next Chef run, the new CSV will be pulled onto the node and this change will trigger a restart of lightdm - we realise this is an extremely heavy-handed approach simply to get a browser to show a different URL, but our target URLs change infrequently so it's not a big deal for us. If, however, you know of a better way to do this, we're always open to PRs

There's a caveat here, however: this change to a single node's CSV will cause all of the nodes to think they have new content and they'll _all_ restart X at the end of their next Chef run. Again, this isn't a big deal for us as we don't change our content too often, but if you can think of a better way...

##Tests

This cookbook has been built using [Test Kitchen](http://kitchen.ci/), to run the tests do:

    git clone https://github.com/theodi/chef-odi-science-tiger
    cd chef-odi-science-tiger
    bundle
    berks install
    kitchen test

(You'll need Vagrant and VirtualBox installed, but I'm guessing that if you've read this far, you have those things)

##Next steps

This is very clearly not a finished thing. So:

###Rotating the URLs

We'd really like to be able to supply a list of URLs in those CSVs, and have the browser roll around them every minute or so. Anybody know an easy way to do this?

###Screen size

By default, we had some pretty thick black bars all around the edge of the displays (on our LG 42LN540V tellies). I've nailed in a fix for this [here](https://github.com/theodi/chef-odi-science-tiger/blob/master/templates/default/config.txt.erb) and [here](https://github.com/theodi/chef-odi-science-tiger/blob/master/attributes/default.rb), but having to potentially set these for each different screen type feels like a hack. Anybody got any suggestions?

##WTF is a Science Tiger?

A Science Tiger is an animal that eats Information Radiators
