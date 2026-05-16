# Kibbcom — Site Management App

A Flutter enterprise dashboard app built with MVVM architecture and 
Riverpod state management. Allows managers to monitor and manage 
operational sites in real time.

---
## App Preview

<table>
<tr>

<td align="center">
<b>Splash Screen</b><br><br>
<img src="./assets/screenshots/splash_screen.png" width="220"/>
</td>

<td align="center">
<b>Home Screen</b><br><br>
<img src="assets\screenshots\home_screen.png" width="220">
</td>

<td align="center">
<b>Fetch Screen</b><br><br>
<img src="assets\screenshots\fetch_screen.png" width="220">
</td>

</tr>
<tr>

<td align="center">
<b>Dashboard Screen</b><br><br>
<img src="assets\screenshots\dashboard_screen.png" width="220">
</td>

<td align="center">
<b>Site Detail Screen</b><br><br>
<img src="assets\screenshots\site_detail_screen.png" width="220">
</td>

<td align="center">
<b>Not Match Found Screen</b><br><br>
<img src="assets\screenshots\match_not_found.png" width="220">
</td>

</tr>
</table>




## What the app does

- Shows a splash screen with an animated brand reveal on launch
- Home screen with a hero card and navigation to the dashboard
- Dashboard lists all operational sites fetched from a simulated API
- Search bar filters sites by name in real time
- Toggle switches change site status between Active and Maintenance
- Summary cards show the total count of Active and Maintenance sites
- Tapping a site card opens a bottom sheet with full details
- Contact Manager button opens the native phone dialler
- Notification sidebar slides in from the right
- Three dot menu with About dialog

---

## Tech stack

| | |
|---|---|
| Framework | Flutter 3.11.0 |
| Language | Dart 3.0 |
| State management | Riverpod (StateNotifier) |
| Architecture | MVVM |
| Animations | flutter_animate |
| Fonts | Google Fonts — DM Sans |
| Phone dialler | url_launcher |
| Device preview | device_preview (desktop only) |

---
