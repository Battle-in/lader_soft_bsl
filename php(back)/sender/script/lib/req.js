function request() {
    let url = 'https://bsl-show.ru/api/getMail.php';
    let data = {
        "to": '',
        "from" : '',
        "title": '' ,
        "text": ' ', 
    };

    //поле ввода для мыло
    //поле ввода для имя
    //поле ввода для телефона
   

    let elem = document.querySelectorAll("form");
        elem.forEach((e)=> {
           
               e.querySelectorAll('input').forEach((input) => {
                   for(let props in data) {
                      if(input.name == 'to' && props == 'to') {
                          data[props] = input.value;
                        }
                        if(input.name == 'from' && props == 'from') {
                            data[props] = input.value;
                        }
                        if(input.name == 'title' && props == 'title') {
                            data[props] = input.value;
                        }
                        if(input.name == 'text' && props == 'text') {
                            data[props] = input.value;
                        }
                   }
               });
        });

        //console.log(data);
        
        axios
        .post(url , data)
        .then(response => {
            console.log(response.data);
        })
        .catch((e) => console.log(e));
  

}