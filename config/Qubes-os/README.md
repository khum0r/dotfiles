Introduction
------------
This is a short guide on how to customize the look and feel of your [Qubes OS].
If your a big fun of using WM as I do. At first when I installed Qubes I
didn't like the default xfce4 destop environment since am used to a WM.

After a long searching I found out [Qubes OS] have an article on setting up [i3] and give it a shot. As always the default i3 look does not look that fancy :blush:. So it was time to rice Qubes.

Rice Overview
-------------
1. Application launcher for `dom0`
    I choose to use [rofi] since it supports icons and it has some extra
    features than `dmenu`.Though I use `dmenu_extended` with my personal domain for quick file browsing e.g pdf and videos.
2. Terminal emulator `rxvt-unicode` 
3. Nitrogen for changing my `dom0` wallpaper.
4. [Polybar] as my status bar of choice.

Getting our files ready
-----------------------
So I had to used `untrusted-domain` to download my files and transfer them
later to `dom0`.

1. Download [bitmap] fonts and [siji] just download as zip.
2. Git clone both polybar and rofi then compress them.
```
$ git clone --branch 3.3 --recursive https://github.com/jaagr/polybar
$ tar cvf polybar.tar polybar
$ git clone https://github.com/DaveDavenport/rofi 
$ cd rofi/ && git submodule update --init && cd ..
$ tar cvf rofi.tar rofi
```
3. Bonus if you need some nice icon-theme download and compress them to any
   form.
4. Transfer your compressed files to `dom0`.
```
[username@dom0]$ qvm-run --pass-io untrusted "cat rofi.tar" > rofi.tar
[username@dom0]$ tar xvf rofi.tar

```
Repeat the same for the remaing files. Note `untrusted` is the domain I used to
download the files make sure to replace it with your own domain.

Installing i3 and (Polybar,Rofi) Dependencies
-----------------------
i3
```
$ sudo qubes-dom0-update i3 i3-settings-qubes
```
If your not able to download `i3-settings-qubes` you can get those scripts from
[here]. Make sure to copy them under `/usr/bin`

Polybar
```
$ sudo qubes-dom0-update gcc-c++ cairo-devel cmake automake xcb-util-devel libxcb-devel xcb-proto xcb-util-image-devel
  i3-ipc wireless-tools-devel libnl3-devel xcb-util-wm-devel
```

Rofi
```
$ sudo qubes-dom0-update flex bison libxkbcommon-devel libxkbcommon-x11-devel xcb-util-xrm-devel pango-devel startup-notifaction-devel librsvg2-devel
```

Installing Rofi and Polybar
---------------------------
#### Polybar
1. `cd` to your uncompressed polybar directory and:
```
$ ./build.sh # Alternative mkdir build && cd build && cmake ..
```

#### Rofi
```
$ # cd to your rofi dir you had uncompressed
$ ./configure --disable-check # disable-check is needed since I was not able to
install check.
```
Add the following line to your `.config/i3/config`
```
# Start polybar
exec --no-startup-id $HOME/.local/bin/barstart
```
 [barstart] a script that start polybar
 
 Screenshots
------------
![rxvt,polybar,i3](https://i.imgur.com/2BVETGf.png)

![rofi](https://i.imgur.com/h31yTlf.png)

[Qubes OS]: https://www.qubes-os.org/
[i3]: https://i3wm.org/
[barstart]:https://github.com/cOb4l7/dotfiles/blob/master/local/.local/bin/barstart
[rofi]: https://github.com/DaveDavenport/rofi
[Polybar]: https://github.com/jaagr/polybar
[bitmap]: https://github.com/Tecate/bitmap-fonts
[siji]:https://github.com/stark/siji
[here]:https://github.com/cOb4l7/dotfiles/tree/master/config/Qubes-os/i3-settings-qubes
