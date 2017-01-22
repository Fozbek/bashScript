<?php
if($_POST){
	$islem = $_POST['islem'];
	$username = $_POST['username'];
	$password = $_POST['password'];
	$can = $_POST['can'];
	$tecrube = $_POST['tecrube'];
	$iksirSayisi = $_POST['iksirSayisi'];
	$oldurulenDusmanMagara = $_POST['oldurulenDusmanMagara'];
	$oldurulenDusmanHelos = $_POST['oldurulenDusmanHelos'];
	$helosGirisKalanDusman = $_POST['helosGirisKalanDusman'];
	try {
	     $db = new PDO("mysql:host=localhost;dbname=fozbek_oyun", "USERNAME", "PASSWORD");
	} catch ( PDOException $e ){
	     print $e->getMessage();
	}
	if ($islem == "giris") {
		$query = $db->query("SELECT username,can,tecrube,iksirSayisi,oldurulenDusmanMagara,oldurulenDusmanHelos,helosGirisKalanDusman 
			FROM oyun WHERE username = '{$username}' AND password = '{$password}'")->fetch(PDO::FETCH_ASSOC);
		if ( $query ){
		    print_r(json_encode($query));
		}
	}
	else if($islem == "kayit"){
		$query = $db->prepare("INSERT INTO oyun
			(username, password)
			values(
				?,
				?
			)");
		$insert = $query->execute(array(
			$username, $password
		));
		if($insert){
			$cikti['basari'] = true;
		}
		else{
			$cikti['basari'] = false;
		}
		echo json_encode($cikti);
	}
	else if($islem == "kontrol"){
		if (!$_POST['password']) {
			$query=$db->prepare("SELECT count(*) as count FROM oyun 
				WHERE username = :username");
		}
		else{
			$query=$db->prepare("SELECT count(*) as count FROM oyun 
				WHERE username = :username AND password = :password");
			$query->bindParam(':password', $password);
		}
		$query->bindParam(':username', $username);
		$query->execute();
		$result = $query -> fetch(PDO::FETCH_ASSOC);
		echo json_encode($result);
	}
	else if($islem == "cikis"){
		$query = $db->prepare("UPDATE oyun SET
			can = :can,
			tecrube = :tecrube,
			iksirSayisi = :iksirSayisi,
			oldurulenDusmanMagara = :oldurulenDusmanMagara,
			oldurulenDusmanHelos = :oldurulenDusmanHelos,
			helosGirisKalanDusman = :helosGirisKalanDusman
			WHERE username = :username
			");
		$update = $query->execute(array(
			":can" => $can,
			":tecrube" => $tecrube,
			":iksirSayisi" => $iksirSayisi,
			":oldurulenDusmanMagara" => $oldurulenDusmanMagara,
			":oldurulenDusmanHelos" => $oldurulenDusmanHelos,
			":helosGirisKalanDusman" => $helosGirisKalanDusman,
			":username" => $username
			));
		if($update){
			$cikti['basari'] = true;
		}
		else{
			$cikti['basari'] = false;
		}
	}
}
?>