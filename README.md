# wanted_pre_onboarding

### 실행설명
- WeatherNow/WeatherAPIKey.plist에 weatherAPI Key 입력 후 실행 부탁드립니다
-----
### 기능설명
1. 첫번째 화면 : 지역별 날씨 정보

* UITableView가 그려지기 전에 UIActivityIndicator가 나타나고, 날씨 데이터가 로드되면 사라집니다.
<img height = "400" src = https://user-images.githubusercontent.com/95616104/174800898-7813bba6-36ef-4b1f-85b1-e8fe64840673.gif >

* 서버에러, invalid API key, invalid parameter 등 WeatehrAPI에서 보내는 에러를 alert 창으로 확인할 수 있습니다. 

<p>
  <img height="450" src="https://user-images.githubusercontent.com/95616104/174805563-4e11191f-45a5-46aa-bd15-1d1ed11d84b5.png"/>
  <img height="450" src="https://user-images.githubusercontent.com/95616104/174805571-54a61fec-46e7-4ca7-a2f5-cc1b9f0b0734.png"/>
</p>

* segue를 통해 두번째 화면으로 이동 및 데이터 전달을 수행합니다.
<br>
2. 두번째 화면 : 선택한 지역의 날씨 상세 정보 

* UIImageView를 extension하여 날씨 아이콘 이미지를 불러올 때 캐시된 정보가 있다면 캐시된 이미지를 활용합니다.
</br>

-----
### 앱 실행 화면
<img height="450" src = https://user-images.githubusercontent.com/95616104/174821267-e6272abc-4e45-491c-bce6-d1199d2f6f5b.gif>
