# Flutter Anime App

A flutter application that loads anime characters and view their details.

## View 
##### (if it lags, kindly wait the browser to load the asset)

  <tr>
    <td><img src="gif/flutter_anime.gif" width=270 height=480></td>

  </tr>


## Tools

### Backend
- Kitsu API https://kitsu.docs.apiary.io/#introduction/json:api
- Random quotes API https://api.quotable.io/random
 
### Packages
   - flutter_bloc
   - dio
   - flutter_offline
   - animated_text_kit
   - intl
   - flutter_svg
 
## Technical Hints

### Architecture and State Management
- Bloc architecture (data, business logic and presentation layers) with cubit.

### Pagination and Performance
- Infinite scrolling pagination is implemented (handled in the cubit not the presentation layer (not based on states)).
- Loading characters as 10 per call (pagination offset) and showing them to the user lazily.

### Search
- Search characters on network using API calls.
- Search in the Loaded character.

### Connectivity
- The connectivity state is tracked automatically.

## Attribution
 - This application was built on the resultant application of the following playlist: https://www.youtube.com/playlist?list=PLwWuxCLlF_ufA0GYYjlx_R4smekKH_AuB

 