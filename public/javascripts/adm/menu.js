if (navigator.userAgent.indexOf('Mozilla/3') != -1 || navigator.userAgent.indexOf('Mozilla/4.0 WebTV') != -1) OAS_version = 10;

	// Codigo para impedir que se faca uma requisicao para ambiente nao seguro.
	if (location.href.indexOf('https') != -1) { OAS_version = 10; } 

	var oas_print_flag = 0;
	function OAS_PrintGLB() {
		if (oas_print_flag == 0) {
			oas_print_flag = 1;
			if (OAS_version >= 11)
			  document.write('<script type="text/javascript" language="Javascript1.1" SRC="' + OAS_url + 'adstream_mjx.ads/' + OAS_sitepage + '/1' + OAS_rns + '@' + OAS_listpos + '?' + OAS_query + '"><\/script>');
		}	 
	}

function menuObj(params) {
			this.div = document.getElementById(params.div);
			this.init();
		}
		
		menuObj.prototype.init = function() {
			var lis = this.div.getElementsByTagName('li');
			for(var i=0,len=lis.length;i<len;i++) {
				if(lis[i].className.indexOf('nivelA')>-1 || lis[i].className.indexOf('nivelB')>-1 || lis[i].className.indexOf('nivelC')>-1) {
					var a = lis[i].getElementsByTagName('a')[0];
					a.onclick = function() {
						menuToogle(this);
						return false;
					}
				}
			}
		}
		
		function menuToogle(obj) {
			obj = obj.parentNode;
			if(obj.className.indexOf('nivelA')>-1) {
				if(obj.className.indexOf('abertoA')>-1) obj.className = 'nivelA'; else obj.className = 'nivelA abertoA';
			} else if(obj.className.indexOf('nivelB')>-1) {
				if(obj.className.indexOf('abertoB')>-1) obj.className = 'nivelB'; else obj.className = 'nivelB abertoB';
			} else {
				if(obj.className.indexOf('abertoC')>-1) obj.className = 'nivelC'; else obj.className = 'nivelC abertoC';
			}
		}