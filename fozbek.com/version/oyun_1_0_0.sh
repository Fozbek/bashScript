#!/bin/bash

function ekraniTemizle(){
	for (( i = 0; i < 50; i++ )); do
		echo
	done
}

ekraniTemizle

###--Bilinen açıklar/sorunlar----###

###------------------------------###


## Eklenecekler
#Helos satın alma sistemi
#Basit eşya sistemi
#Canavalardan para düşme sistemi --Eklendi


##Yedek değişken sistemi--
#declare -A canavarlar
#baslangicSatiri=$LINENO
#canavarlar[isim,0]="Zombi"
#canavarlar[isim,1]="iskelet"
#bitisSatiri=$LINENO
#canavarlar[can,0]=10
#echo $(($bitisSatiri-$baslangicSatiri))
##Yedek değişken sistemi--


## Bölümler
#1. Mağara
#2. Hellos

#renkler
renkKirmizi=`tput setaf 1`
renkYesil=`tput setaf 2`
renkSari=`tput setaf 3`
renkMor=`tput setaf 5`
renkMavi=`tput setaf 6`
renkReset=`tput sgr0`


dusmanlar=(İskelet Zombi Savaşçı Ninja Haydut)
dusmanHasarlar=(15 18 25 20 17)
dusmanCanlar=(25 45 50 30 32)
dusmanTecrubeler=(12 22 25 15 19)
dusmanParalar=(150 250 300 170 185)

#echo ${dusmanlar[*]}
#echo ${dusmanHasar[*]}
#echo ${dusmanCan[*]}

levelTecrube=(30 60 100 150 200 300 450 650)

##Karakter Değişkenleri
can=100
para=0
tecrube=0
seviye=1
hasar=50
canIksiri=3


canIksiriYenilemesi=30

##Mağara Değişkenleri##
magara=true
oldurulenDusman[magara]=0
magaraKalanDusman=4

##Helos Değişkenleri##
helos=true
oldurulenDusman[helos]=0
#Giriş Değişkenleri
helosGiris=true
helosGirisKalanDusman=2
helosSehirMerkezi=true

url="http://test.fozbek.com/oyun/"
sifrelerUyusuyor=false


function girisYap(){
	username=$1
	password=$2
	gelenveri="$(curl -s --request POST $url'curl.php' \
	--data 'islem=giris&username='$username'&password='$password)"
	isim="$(echo $gelenveri | grep -Po '(?<=\"username\":\")[^\"]*')"
	can="$(echo $gelenveri | grep -Po '(?<=\"can\":\")[^\"]*')"
	tecrube="$(echo $gelenveri | grep -Po '(?<=\"tecrube\":\")[^\"]*')"
	iksirSayisi="$(echo $gelenveri | grep -Po '(?<=\"iksirSayisi\":\")[^\"]*')"
	oldurulenDusman[magara]="$(echo $gelenveri | grep -Po '(?<=\"oldurulenDusmanMagara\":\")[^\"]*')"
	oldurulenDusman[helos]="$(echo $gelenveri | grep -Po '(?<=\"oldurulenDusmanHelos\":\")[^\"]*')"
	helosGirisKalanDusman="$(echo $gelenveri | grep -Po '(?<=\"helosGirisKalanDusman\":\")[^\"]*')"
	echo "${renkYesil}Başarıyla giriş yaptınız.${renkReset}"
}

function kayitOl(){
	username=$1
	password=$2
	gelenveri="$(curl -s --request POST $url'curl.php' \
	--data 'islem=kayit&username='$username'&password='$password)"
	basari="$(echo $gelenveri | grep -Po '(?<=\"basari\":\")[^\"]*')"
	echo $basari
}

function oyuncuVarMi(){
	username=$1
	password=$2
	if [[ -n $password ]]; then
		gelenveri="$(curl -s --request POST $url'curl.php' \
		--data 'islem=kontrol&username='$username'&password='$password)"
	else
		gelenveri="$(curl -s --request POST $url'curl.php' \
		--data 'islem=kontrol&username='$username)"
	fi	
	count="$(echo $gelenveri | grep -Po '(?<=\"count\":\")[^\"]*')"
	echo $count
}

giris=false
function oyunGiris(){
	if [[ -z $1 ]]; then
		echo "Kullanım, $0 <username>"
		exit
	elif [[ $(oyuncuVarMi $1) -eq 1 ]]; then
		echo "Merhaba $1, lütfen şifrenizi girin."
		while [[ $giris -eq false ]]; do
			echo -n "Şifre:"
			read -s password
			echo
			if [[ $(oyuncuVarMi $1 $password) -eq 1 ]]; then
				girisYap $1 $password
				giris=true
				break
			else
				echo "Şifreniz yanlış, lütfen tekrar deneyin."
			fi
		done
	else
		echo "Merhaba $1, devam edebilmeniz için üye olmalısınız."
		while [[ $sifrelerUyusuyor -eq false ]]; do
			echo "Şifrenizi girin:"
			read -s password
			echo "Şifrenizi tekrar girin:"
			read -s password2
			if [[ $password -eq $password2 ]]; then
				if [[ $(kayitOl $1 $password) -eq "true" ]]; then
					echo ${renkYesil}"Başarıyla kayıt oldunuz."${renkReset}
				else
					echo "Kayıt olma esnasında sorun oluştu. Daha sonra tekrar deneyin."
					exit
				fi
				sifrelerUyusuyor=true
				break
			else
				echo "Şifreleriniz uyuşmuyor, tekrar deneyin."
			fi
		done
	fi
}

function oyunuKapat(){
	echo "oyunu kapat"
}

function sovalye(){
	echo -n ${renkKirmizi}
	echo $'      _,.'
	echo $'    ,` -.)'
	echo $'   \'( _/\'-\\\\-.'
	echo $'  /,|`--._,-^|          '
	echo $'  \\_| |`-._/||          ,\'|'
	echo $'    |  `-, / |         /  /'
	echo $'    |     || |        /  /'
	echo $'     `r-._||/   __   /  /'
	echo $' __,-<_     )`-/  `./  /'
	echo $'\'  \\   `---\'   \\   /  /'
	echo $'    |           |./  /'
	echo $'    /           //  /'
	echo $'\\_/\' \\         |/  /'
	echo $' |    |   _,^-\'/  /'
	echo $' |    , ``  (\\/  /_'
	echo $'  \\,.->._    \\X-=/^'
	echo $'  (  /   `-._//^`'
	echo $'   `Y-.____(__}'
	echo $'    |     {__)'
	echo $'          ()`'
	echo -n ${renkReset}
}

function envanterGoster(){
	echo ${renkSari}
	echo "#-- Envanter --#"
	echo "Para: $para"
	echo "Can İksiri Sayısı: $canIksiri"
	echo "#-- Envanter --#"
	echo ${renkReset}
}

function helosMarket(){
	echo "market"
}

function seviyeGuncelle(){
	((geciciTecrube=tecrube*tecrube*tecrube))
	calc=$(echo "sqrt(sqrt(sqrt($geciciTecrube)))" | bc)
	((seviye=$calc-2))	
}

function dusmeSansi(){ ##İksir ve para düşme şansı. 
	if [[ $(($RANDOM%3)) -eq 1 ]]; then #3'te 1
		echo 1
	fi
}

function canIksiriKullan(){ ##Can iksiri kullan
	if (( $canIksiri > 0 )); then
		((canIksiri--))
		echo "Can iksiri kullandın. Kalan can iksiri $canIksiri"
		((can=can+canIksiriYenilemesi))
	else
		echo "Can iksirin kalmadı."
	fi
}

function olunce(){ ##Ölünce olacaklar
	echo "Çok fazla hasar aldın, devam etmek için çok zayıfsın"
	echo "Düşmandan kaçmayı başardın, kendine gelmen için 10 saniye dinlenmen gerekiyor."
	sleep 2 #Ölünce beklenecek süre
	can=50 #Ölünce başlangıç canı
}

function karakterBilgileri(){ ##Karakter bilgisini bas
	echo ${renkSari}
	echo "#--Karakter Bilgileri--#"
	echo "Tecrüben: $tecrube"
	echo "Seviyen: $seviye"
	echo "Senin Canın: $can"
	echo "#--Karakter Bilgileri--#"
	echo ${renkReset}
}

function dusmanOldurunce(){
	dusmanVerdigiTecrube=${dusmanTecrubeler[$1]}
	dusmanVerdigiPara=${dusmanParalar[$1]}
	((para=para+dusmanVerdigiPara))
	echo -n ${renkYesil}
	echo "Bir düşman öldürdün."
	((tecrube=tecrube+dusmanVerdigiTecrube))
	seviyeGuncelle
	if [[ $(dusmeSansi) -eq 1 ]]; then
		((canIksiri++))
		echo "Düşmandan bir adet can iksiri düştü."
		echo "Toplam can iksiri miktarı: $canIksiri"
	fi
	if [[ $(dusmeSansi) -eq 1 ]]; then
		echo "Düşmandan $dusmanVerdigiPara para düştü."
	fi
	echo -n ${renkReset}
}

function vadiKolyeDusmeSansi(){
	if [[ $(($RANDOM%4)) -eq 1 ]]; then #4'te 1
		echo 1
	fi
}

function vadi(){
	echo "Vadiye hoşgeldin."
}

function yasliAdam(){
	echo ${renkYesil}
	echo "Merhaba genç adam, senin için bir görevim var."
	echo "Vadinin yanından geçerken haydutlar önümü kestiler ve"
	echo "benim için çok değerli olan bir kolyeyi çaldılar."
	echo "Eğer onu bana getirebilirsen sana 10.000 para vereceğim."
	echo ${renkReset}
	echo "Ne yapmak istersin ?"
	echo "1. Kabul et"
	echo "2. Reddet"
	read secim
	case $secim in
		1 )
			vadi
		;;
		2 )
			echo "Redettin."
		;;
		* )
			echo "Hatalı tuşlama."
		;;
	esac
}

function bolumMagara(){
	while [ $magara == "true" ]; do
		dusmanIndis=$((RANDOM%${#dusmanlar[@]}))
		dusman=${dusmanlar[$dusmanIndis]}
		dusmanCan=${dusmanCanlar[$dusmanIndis]}
		dusmanHasar=${dusmanHasarlar[$dusmanIndis]}
		dusmanVerdigiPara=$((RANDOM%${dusmanParalar[$dusmanIndis]}))

		echo "Karşınıza $dusman çıktı!"
		
		while (( $dusmanCan > 1 )); do #Düşman ölmedikçe döner
			karakterBilgileri
			echo "$dusman adlı düşmanın canı $dusmanCan"
			echo "Ne yapmak istersin ?"
			echo "1. Saldır"
			echo "2. Can iksiri kullan"
			if [[ ${oldurulenDusman[magara]} -gt 1 ]]; then
				echo "3. Mağaradan çık"
			fi
			read secim
			case $secim in
				1 ) #Saldır
					verilenHasar=$((RANDOM%$hasar))
					alinanHasar=$((RANDOM%$dusmanHasar))

					((dusmanCan=dusmanCan-verilenHasar))
					((can=can-alinanHasar))
					echo ""
					echo "$dusman adlı düşmana $verilenHasar hasar verdin."
					echo "$alinanHasar hasar aldın."

					if (( "$dusmanCan" <= 0 )); then
						((oldurulenDusman[magara]++))
						dusmanOldurunce dusmanIndis #fonksiyona parametre olarak dusman indisi gönderiyorum
						((magaraKalanDusman--))
						if [[ $magaraKalanDusman -eq 0 ]]; then
							echo "Mağarada daha fazla düşman kalmadı, mağaradan çıkıyorsun..."
							magara=false
							break
						fi
						if [[ ${oldurulenDusman[magara]} -eq 1 ]]; then
							echo "Mağaradan çıkman için 1 düşman daha öldürmen gerekiyor."
						elif [[ ${oldurulenDusman[magara]} -eq 2 ]]; then
							echo -n ${renkYesil}
							echo "Mağarada 2 düşman kaldı, istersen çıkabilirsin."
							echo -n ${renkReset}
						fi
					fi

					if (( $can < 1 )); then
						olunce
						echo "Kendine gelmeye başladın, görevini yerine getirip bu mağaradan bir an önce çıkmalısın."
						break
					fi
				;;
				2 ) #Can iksiri
					canIksiriKullan
				;;
				3 ) #Mağaradan çık
					if [[ ${oldurulenDusman[magara]} -gt 1 ]]; then
						echo "Görevini tamamlayıp mağaradan çıkmayı başardın."
						magara=false
						break
					else
						echo "Hatalı giriş."
					fi
				;;
				* )
					echo "Hatalı giriş."
				;;
			esac
		done
	done
	ekraniTemizle
	echo "Helos'a doğru ilerliyorsun."
}

function bolumHellos(){
	sovalye
	echo "Köy merkezinin girişinde 2 iskeletin muhafızlarla savaştığını görüyorsun,"
	echo "ne yapmak istersin ?"

	#while [ $helosGiris == "true" ]; do
		while [ $helosGirisKalanDusman -ne 0 ]; do
			dusmanCan=${dusmanCanlar[0]}
			dusmanHasar=${dusmanHasarlar[0]}

			while (( $dusmanCan > 1 )); do #Düşman ölmedikçe döner
				karakterBilgileri
				echo "Düşmanın canı $dusmanCan"
				echo "Ne yapmak istersin ?"
				echo "1. Saldır"
				echo "2. Can iksiri kullan"
				echo "3. Şehre gir"
				read secim
				case $secim in
					1 ) #Saldır
						verilenHasar=$((RANDOM%$hasar))
						alinanHasar=$((RANDOM%$dusmanHasar))

						((dusmanCan=dusmanCan-verilenHasar))
						((can=can-alinanHasar))
						echo ""
						echo "İskelete $verilenHasar hasar verdin."
						echo "$alinanHasar hasar aldın."

						if (( $dusmanCan <= 0 )); then
							((helosGirisKalanDusman--))
							dusmanOldurunce 0 # 0 iskeletin indisi
							if [[ $helosGirisKalanDusman -eq 0 ]]; then
								echo "Daha fazla düşman kalmadı, şehir merkezine doğru ilerliyorsun."
								helosGiris=false
								break
							fi
							if [[ $helosGirisKalanDusman -eq 1 ]]; then
								echo "1 iskelet kaldı, istersen görmezden gelip şehir merkezine girebilirsin."
							fi
						fi

						if (( $can < 1 )); then
							olunce
							echo "Kendine gelmeye başladın, istersen iskeletleri görmezden gelip şehir merkezine girebilirsin."
							break
						fi
					;;
					2 ) #İksir kullan
						canIksiriKullan
					;;
					3 ) #Görmezden gel
						if [[ $helosGirisKalanDusman -eq 2 ]]; then
							echo "İskeletleri görmezden gelip şehre girdin."
						elif [[ $helosGirisKalanDusman -eq 1 ]]; then
							echo "İskeleti görmezden gelip şehre girdin."
						fi
						helosGirisKalanDusman=0
						helosGiris=false
						break
					;;
					* )
						echo "Hatalı giriş."
					;;
				esac
			done
		done
	#done
	echo ""
	echo ${renkKirmizi}"Şehir merkezinde yaşlı bir adamın sana seslendiğini fark ediyorsun."${renkReset}
	while [[ $helos == "true" ]]; do
		echo "Helos - Ne yapmak istersin ?"
		echo "1. Envanterini görüntüle"
		echo "2. Markete git"
		echo "3. Yaşlı adamın yanına git"
		echo "0. Oyundan çık"
		read secim
		case $secim in
			1 )
				envanterGoster
			;;
			2 )
				helosMarket
			;;
			3 )
				yasliAdam
			;;
			0 )
				oyunuKapat
			;;
			* )
				echo "Hatalı giriş."
			;;
		esac
	done
}


oyunGiris $1
echo "Mağara hoşgeldin. Mağarada toplam $magaraKalanDusman düşman var"
echo "Bu mağaradan çıkman için en az 2 düşman öldürmen gerekiyor."
bolumMagara
bolumHellos