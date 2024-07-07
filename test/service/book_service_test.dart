import 'dart:convert';

import 'package:book_app/model/book_model.dart';
import 'package:book_app/core/client_http/client_http.dart';
import 'package:book_app/core/client_http/dio_client.dart';
import 'package:book_app/modules/books/repository/book_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class ClientHttpMock extends Mock implements ClientHttp{}

void main() {
  final client = ClientHttpMock();
  final service = BookRepository(client);

  test("deve fazer a request", () async{
    when(()=> client.get(any())).thenAnswer((_) async => jsonDecode(json));

    List<Book> listBook = await service.fetchAll("percy_jackson");
    int index = 1;
    print(listBook[index].volumeInfo.title);
    print(listBook[index].volumeInfo.authors);
    print(listBook[index].volumeInfo.publisher);
    print(listBook[index].volumeInfo.publishedDate);
    print(listBook[index].volumeInfo.description);
    print(listBook[index].volumeInfo.pageCount);
    print(listBook[index].volumeInfo.categories);
    print(listBook[index].volumeInfo.imageLinks!.smallThumb);
    print(listBook[index].volumeInfo.imageLinks!.thumbnail);


    expect(listBook[index].volumeInfo.title, "Percy Jackson E Os Ladroes Do Olimpo");
  });
  final cliente = DioClient();
  final services = BookRepository(cliente);

  test("deve fazer pegar 3 livros", () async{
    var list = ["lfHo7uMk7r4C", "gHe3wAEACAAJ", "V6A0zgEACAAJ"];
    var listaa = await services.fetchFavoritesBooks(list);
    listaa.forEach((e) => print(e.volumeInfo.title));
  });
}


const json = r"""{
  "kind": "books#volumes",
  "totalItems": 759,
  "items": [
    {
      "kind": "books#volume",
      "id": "hDwn0AEACAAJ",
      "etag": "SHJSmx0qOV8",
      "selfLink": "https://www.googleapis.com/books/v1/volumes/hDwn0AEACAAJ",
      "volumeInfo": {
        "title": "Box Percy Jackson e os olimpianos",
        "authors": [
          "Rick Riordan"
        ],
        "publishedDate": "2015-03-31",
        "description": "Combinando mitologia grega e muita aventura, a saga do menino Percy Jackson, que aos 12 anos descobre que é um semideus, filho de Poseidon, tornou-se um fenômeno mundial. Foram mais de 15 milhões de livros vendidos em todo o mundo e quase um milhão no Brasil, além da adaptação para o cinema que atraiu 1,8 milhão de espectadores no país. Agora, os fãs da série podem ter, reunidos em um box especial, com edição limitada e design exclusivo, os cinco livros da saga que consagrou o autor Rick Riordan: O ladrão de raios, em que Percy descobre sua ligação com os deuses do Olimpo e precisa impedir uma guerra entre eles, que acabaria com toda a civilização ocidental; O Mar de Monstros, quando ele e seus amigos se envolvem numa perigosa aventura para defender o Acampamento Meio-Sangue; A maldição do Titã, em que nosso herói descobre que Cronos, o Senhor dos Titãs, despertou e está disposto a destruir toda a humanidade; A batalha do Labirinto, em que Percy, Tyson, Annabeth e Grover são destacados para combater o perigoso Titã nos corredores do temido Labirinto de Dédalo; O último Olimpiano, quando o confronto toma as ruas de Nova York e Percy tem de lidar não só com o exército de Cronos, mas também com a chegada de seu 16o aniversário e, com ele, com a profecia que determinará seu destino.",
        "industryIdentifiers": [
          {
            "type": "ISBN_10",
            "identifier": "8580574625"
          },
          {
            "type": "ISBN_13",
            "identifier": "9788580574623"
          }
        ],
        "readingModes": {
          "text": false,
          "image": false
        },
        "pageCount": 0,
        "printType": "BOOK",
        "categories": [
          "Young Adult Fiction"
        ],
        "maturityRating": "NOT_MATURE",
        "allowAnonLogging": false,
        "contentVersion": "preview-1.0.0",
        "panelizationSummary": {
          "containsEpubBubbles": false,
          "containsImageBubbles": false
        },
        "language": "pt-BR",
        "previewLink": "http://books.google.com.br/books?id=hDwn0AEACAAJ&dq=percy_jackson&hl=&cd=1&source=gbs_api",
        "infoLink": "http://books.google.com.br/books?id=hDwn0AEACAAJ&dq=percy_jackson&hl=&source=gbs_api",
        "canonicalVolumeLink": "https://books.google.com/books/about/Box_Percy_Jackson_e_os_olimpianos.html?hl=&id=hDwn0AEACAAJ"
      },
      "saleInfo": {
        "country": "BR",
        "saleability": "NOT_FOR_SALE",
        "isEbook": false
      },
      "accessInfo": {
        "country": "BR",
        "viewability": "NO_PAGES",
        "embeddable": false,
        "publicDomain": false,
        "textToSpeechPermission": "ALLOWED",
        "epub": {
          "isAvailable": false
        },
        "pdf": {
          "isAvailable": false
        },
        "webReaderLink": "http://play.google.com/books/reader?id=hDwn0AEACAAJ&hl=&source=gbs_api",
        "accessViewStatus": "NONE",
        "quoteSharingAllowed": false
      },
      "searchInfo": {
        "textSnippet": "Agora, os fãs da série podem ter, reunidos em um box especial, com edição limitada e design exclusivo, os cinco livros da saga que consagrou o autor Rick Riordan: O ladrão de raios, em que Percy descobre sua ligação com os deuses do ..."
      }
    },
    {
      "kind": "books#volume",
      "id": "gHe3wAEACAAJ",
      "etag": "9+07tRdk1sQ",
      "selfLink": "https://www.googleapis.com/books/v1/volumes/gHe3wAEACAAJ",
      "volumeInfo": {
        "title": "Percy Jackson E Os Ladroes Do Olimpo",
        "authors": [
          "Rick Riordan"
        ],
        "publisher": "Leya",
        "publishedDate": "2010",
        "description": "Twelve-year-old Percy Jackson learns he is a demigod, the son of a mortal woman and Poseidon, god of the sea. His mother sends him to a summer camp for demigods where he and his new friends set out on a quest to prevent a war between the gods.",
        "industryIdentifiers": [
          {
            "type": "ISBN_10",
            "identifier": "9724619370"
          },
          {
            "type": "ISBN_13",
            "identifier": "9789724619378"
          }
        ],
        "readingModes": {
          "text": false,
          "image": false
        },
        "pageCount": 326,
        "printType": "BOOK",
        "categories": [
          "Camps"
        ],
        "maturityRating": "NOT_MATURE",
        "allowAnonLogging": false,
        "contentVersion": "preview-1.0.0",
        "panelizationSummary": {
          "containsEpubBubbles": false,
          "containsImageBubbles": false
        },
        "imageLinks": {
          "smallThumbnail": "http://books.google.com/books/content?id=gHe3wAEACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api",
          "thumbnail": "http://books.google.com/books/content?id=gHe3wAEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"
        },
        "language": "pt-BR",
        "previewLink": "http://books.google.com.br/books?id=gHe3wAEACAAJ&dq=percy_jackson&hl=&cd=2&source=gbs_api",
        "infoLink": "http://books.google.com.br/books?id=gHe3wAEACAAJ&dq=percy_jackson&hl=&source=gbs_api",
        "canonicalVolumeLink": "https://books.google.com/books/about/Percy_Jackson_E_Os_Ladroes_Do_Olimpo.html?hl=&id=gHe3wAEACAAJ"
      },
      "saleInfo": {
        "country": "BR",
        "saleability": "NOT_FOR_SALE",
        "isEbook": false
      },
      "accessInfo": {
        "country": "BR",
        "viewability": "NO_PAGES",
        "embeddable": false,
        "publicDomain": false,
        "textToSpeechPermission": "ALLOWED",
        "epub": {
          "isAvailable": false
        },
        "pdf": {
          "isAvailable": false
        },
        "webReaderLink": "http://play.google.com/books/reader?id=gHe3wAEACAAJ&hl=&source=gbs_api",
        "accessViewStatus": "NONE",
        "quoteSharingAllowed": false
      },
      "searchInfo": {
        "textSnippet": "Twelve-year-old Percy Jackson learns he is a demigod, the son of a mortal woman and Poseidon, god of the sea."
      }
    },
    {
      "kind": "books#volume",
      "id": "V6A0zgEACAAJ",
      "etag": "f7WSmNq1qJE",
      "selfLink": "https://www.googleapis.com/books/v1/volumes/V6A0zgEACAAJ",
      "volumeInfo": {
        "title": "Box Percy Jackson e os Olimpianos",
        "authors": [
          "Rick Riordan"
        ],
        "publisher": "Intrínseca",
        "publishedDate": "2010-11-01",
        "description": "O Box reúne os cinco livros da série.",
        "industryIdentifiers": [
          {
            "type": "ISBN_10",
            "identifier": "8580572916"
          },
          {
            "type": "ISBN_13",
            "identifier": "9788580572919"
          }
        ],
        "readingModes": {
          "text": false,
          "image": false
        },
        "pageCount": 1207,
        "printType": "BOOK",
        "categories": [
          "Juvenile Fiction"
        ],
        "averageRating": 4,
        "ratingsCount": 2,
        "maturityRating": "NOT_MATURE",
        "allowAnonLogging": false,
        "contentVersion": "preview-1.0.0",
        "panelizationSummary": {
          "containsEpubBubbles": false,
          "containsImageBubbles": false
        },
        "imageLinks": {
          "smallThumbnail": "http://books.google.com/books/content?id=V6A0zgEACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api",
          "thumbnail": "http://books.google.com/books/content?id=V6A0zgEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"
        },
        "language": "pt",
        "previewLink": "http://books.google.com.br/books?id=V6A0zgEACAAJ&dq=percy_jackson&hl=&cd=3&source=gbs_api",
        "infoLink": "http://books.google.com.br/books?id=V6A0zgEACAAJ&dq=percy_jackson&hl=&source=gbs_api",
        "canonicalVolumeLink": "https://books.google.com/books/about/Box_Percy_Jackson_e_os_Olimpianos.html?hl=&id=V6A0zgEACAAJ"
      },
      "saleInfo": {
        "country": "BR",
        "saleability": "NOT_FOR_SALE",
        "isEbook": false
      },
      "accessInfo": {
        "country": "BR",
        "viewability": "NO_PAGES",
        "embeddable": false,
        "publicDomain": false,
        "textToSpeechPermission": "ALLOWED",
        "epub": {
          "isAvailable": false
        },
        "pdf": {
          "isAvailable": false
        },
        "webReaderLink": "http://play.google.com/books/reader?id=V6A0zgEACAAJ&hl=&source=gbs_api",
        "accessViewStatus": "NONE",
        "quoteSharingAllowed": false
      },
      "searchInfo": {
        "textSnippet": "O Box reúne os cinco livros da série."
      }
    },
    {
      "kind": "books#volume",
      "id": "W_NKvgAACAAJ",
      "etag": "c2zg730OVL8",
      "selfLink": "https://www.googleapis.com/books/v1/volumes/W_NKvgAACAAJ",
      "volumeInfo": {
        "title": "LADRAO DE RAIOS, O (CAPA NOVA)",
        "authors": [
          "RICK RIORDAN",
          "RICARDO GOUVEIA"
        ],
        "publishedDate": "2014-08-18",
        "description": "O autor conjuga lendas da mitologia grega com aventuras no século XXI. Nelas, os deuses do Olimpo continuam vivos, ainda se apaixonam por mortais e geram filhos metade deuses, metade humanos, como os heróis da Grécia antiga. Marcados pelo destino, eles dificilmente passam da adolescência. Poucos conseguem descobrir sua identidade. O garoto-problema Percy Jackson é um deles. Tem experiências estranhas em que deuses e monstros mitológicos parecem saltar das páginas dos livros direto para a sua vida. Pior que isso - algumas dessas criaturas estão bastante irritadas. Um artefato precioso foi roubado do Monte Olimpo e Percy é o principal suspeito. Para restaurar a paz, ele e seus amigos - jovens heróis modernos - terão de fazer mais do que capturar o verdadeiro ladrão - precisam elucidar uma traição mais ameaçadora que a fúria dos deuses.",
        "industryIdentifiers": [
          {
            "type": "ISBN_10",
            "identifier": "8580575397"
          },
          {
            "type": "ISBN_13",
            "identifier": "9788580575392"
          }
        ],
        "readingModes": {
          "text": false,
          "image": false
        },
        "pageCount": 400,
        "printType": "BOOK",
        "maturityRating": "NOT_MATURE",
        "allowAnonLogging": false,
        "contentVersion": "preview-1.0.0",
        "panelizationSummary": {
          "containsEpubBubbles": false,
          "containsImageBubbles": false
        },
        "language": "pt-BR",
        "previewLink": "http://books.google.com.br/books?id=W_NKvgAACAAJ&dq=percy_jackson&hl=&cd=4&source=gbs_api",
        "infoLink": "http://books.google.com.br/books?id=W_NKvgAACAAJ&dq=percy_jackson&hl=&source=gbs_api",
        "canonicalVolumeLink": "https://books.google.com/books/about/LADRAO_DE_RAIOS_O_CAPA_NOVA.html?hl=&id=W_NKvgAACAAJ"
      },
      "saleInfo": {
        "country": "BR",
        "saleability": "NOT_FOR_SALE",
        "isEbook": false
      },
      "accessInfo": {
        "country": "BR",
        "viewability": "NO_PAGES",
        "embeddable": false,
        "publicDomain": false,
        "textToSpeechPermission": "ALLOWED",
        "epub": {
          "isAvailable": false
        },
        "pdf": {
          "isAvailable": false
        },
        "webReaderLink": "http://play.google.com/books/reader?id=W_NKvgAACAAJ&hl=&source=gbs_api",
        "accessViewStatus": "NONE",
        "quoteSharingAllowed": false
      },
      "searchInfo": {
        "textSnippet": "Twelve-year-old Percy Jackson learns he is a demigod, the son of a mortal woman and Poseidon, god of the sea."
      }
    },
    {
      "kind": "books#volume",
      "id": "T9zQEAAAQBAJ",
      "etag": "N5ypBfhYMrc",
      "selfLink": "https://www.googleapis.com/books/v1/volumes/T9zQEAAAQBAJ",
      "volumeInfo": {
        "title": "O cálice dos Deuses",
        "subtitle": "Série Percy Jackson e os olimpianos",
        "authors": [
          "Rick Riordan"
        ],
        "publisher": "Editora Intrinseca",
        "publishedDate": "2023-09-26",
        "description": "Percy Jackson, protagonista da série best-seller de Rick Riordan, está de volta em nova aventura hilária Após quase dez anos de espera, os fãs do semideus mais amado — e azarado — da literatura já podem comemorar: Percy Jackson está de volta! No aguardado novo título da série Percy Jackson e os olimpianos, que chega ao Brasil em lançamento simultâneo, o filho de Poseidon se prepara para uma de suas missões mais difíceis até agora: entrar na faculdade. Depois de salvar o mundo inúmeras vezes de monstros, titãs, gigantes e outras criaturas aterrorizantes, tudo que Percy deseja é que seu último ano no ensino médio seja tranquilo. Infelizmente, os deuses têm outros planos para o jovem herói. Se ele quiser mesmo entrar na universidade, terá que cumprir três missões para conquistar três cartas de recomendação vindas diretamente do Monte Olimpo. A primeira missão envolve ajudar o copeiro de Zeus a recuperar seu cálice antes que ele caia nas mãos erradas. Será que Percy, Annabeth e Grover conseguirão achar o cálice dos deuses a tempo? Unindo aventura, ação e mitologia grega a personagens apaixonantes e tramas hilárias, a série Percy Jackson e os olimpianos transformou a literatura jovem nos últimos anos e conquistou fãs no mundo inteiro. A história de Rick Riordan sobre um adolescente com TDAH que descobre ser filho do deus do mar e precisa navegar entre o mundo humano e o divino se tornou um best-seller e formou uma geração de leitores apaixonados que até hoje acompanham a saga de Percy e seus amigos. O sucesso da série chegou também às telas, em uma adaptação da plataforma de streaming Disney+ com estreia prevista para 2024.",
        "industryIdentifiers": [
          {
            "type": "ISBN_13",
            "identifier": "9786555606485"
          },
          {
            "type": "ISBN_10",
            "identifier": "6555606487"
          }
        ],
        "readingModes": {
          "text": true,
          "image": true
        },
        "pageCount": 218,
        "printType": "BOOK",
        "categories": [
          "Juvenile Fiction"
        ],
        "maturityRating": "NOT_MATURE",
        "allowAnonLogging": true,
        "contentVersion": "2.2.2.0.preview.3",
        "panelizationSummary": {
          "containsEpubBubbles": false,
          "containsImageBubbles": false
        },
        "imageLinks": {
          "smallThumbnail": "http://books.google.com/books/content?id=T9zQEAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
          "thumbnail": "http://books.google.com/books/content?id=T9zQEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
        },
        "language": "pt-BR",
        "previewLink": "http://books.google.com.br/books?id=T9zQEAAAQBAJ&printsec=frontcover&dq=percy_jackson&hl=&cd=5&source=gbs_api",
        "infoLink": "https://play.google.com/store/books/details?id=T9zQEAAAQBAJ&source=gbs_api",
        "canonicalVolumeLink": "https://play.google.com/store/books/details?id=T9zQEAAAQBAJ"
      },
      "saleInfo": {
        "country": "BR",
        "saleability": "FOR_SALE",
        "isEbook": true,
        "listPrice": {
          "amount": 39.9,
          "currencyCode": "BRL"
        },
        "retailPrice": {
          "amount": 35.91,
          "currencyCode": "BRL"
        },
        "buyLink": "https://play.google.com/store/books/details?id=T9zQEAAAQBAJ&rdid=book-T9zQEAAAQBAJ&rdot=1&source=gbs_api",
        "offers": [
          {
            "finskyOfferType": 1,
            "listPrice": {
              "amountInMicros": 39900000,
              "currencyCode": "BRL"
            },
            "retailPrice": {
              "amountInMicros": 35910000,
              "currencyCode": "BRL"
            },
            "giftable": true
          }
        ]
      },
      "accessInfo": {
        "country": "BR",
        "viewability": "PARTIAL",
        "embeddable": true,
        "publicDomain": false,
        "textToSpeechPermission": "ALLOWED",
        "epub": {
          "isAvailable": true,
          "acsTokenLink": "http://books.google.com.br/books/download/O_c%C3%A1lice_dos_Deuses-sample-epub.acsm?id=T9zQEAAAQBAJ&format=epub&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api"
        },
        "pdf": {
          "isAvailable": true,
          "acsTokenLink": "http://books.google.com.br/books/download/O_c%C3%A1lice_dos_Deuses-sample-pdf.acsm?id=T9zQEAAAQBAJ&format=pdf&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api"
        },
        "webReaderLink": "http://play.google.com/books/reader?id=T9zQEAAAQBAJ&hl=&source=gbs_api",
        "accessViewStatus": "SAMPLE",
        "quoteSharingAllowed": false
      },
      "searchInfo": {
        "textSnippet": "A história de Rick Riordan sobre um adolescente com TDAH que descobre ser filho do deus do mar e precisa navegar entre o mundo humano e o divino se tornou um best-seller e formou uma geração de leitores apaixonados que até hoje ..."
      }
    },
    {
      "kind": "books#volume",
      "id": "_2gtBgAAQBAJ",
      "etag": "TGZ1UCb1lYw",
      "selfLink": "https://www.googleapis.com/books/v1/volumes/_2gtBgAAQBAJ",
      "volumeInfo": {
        "title": "Percy Jackson e os deuses gregos",
        "subtitle": "Os arquivos do semideus",
        "authors": [
          "Rick Riordan"
        ],
        "publisher": "Editora Intrinseca",
        "publishedDate": "2015-02-25",
        "description": "\"Um editor de Nova York pediu que eu escrevesse o que sei sobre os deuses gregos, e fiquei pensando: “Pode ser anonimamente? Porque não estou a fim de despertar a ira dos olimpianos de novo.” Mas, se assim eu estiver ajudando vocês a conhecer os deuses gregos e a sobreviver caso algum dia eles apareçam na sua frente, então acho que escrever isso tudo vai ser minha boa ação da semana.\" - Percy Jackson Para todos que acompanharam o adolescente Percy Jackson enquanto ele se descobria um semideus, enfrentava monstros e entrava em contato com todo tipo de divindades e seres mitológicos, chegou a hora de conhecer com detalhes as histórias dos doze principais deuses gregos, contadas por ninguém menos que o próprio Percy. Em Percy Jackson e os deuses gregos nosso querido semideus explica a versão da mitologia grega para a criação do mundo e dá aos leitores sua visão pessoal sobre quem é quem na Grécia Antiga, de Apollo a Zeus. “O dom de Percy, e isso não é nenhum segredo, é soprar vida nova nos deuses. Este livro é a inevitável sequência para a legião de fãs de Percy que querem conhecer as histórias por trás das histórias.” Kirkus Reviews “A narração de Percy, repleta de comentários sagazes, é deliciosa.” Publishers Weekly Best-seller da Veja",
        "industryIdentifiers": [
          {
            "type": "ISBN_13",
            "identifier": "9788580576344"
          },
          {
            "type": "ISBN_10",
            "identifier": "8580576342"
          }
        ],
        "readingModes": {
          "text": true,
          "image": true
        },
        "pageCount": 462,
        "printType": "BOOK",
        "categories": [
          "Juvenile Fiction"
        ],
        "maturityRating": "NOT_MATURE",
        "allowAnonLogging": true,
        "contentVersion": "1.16.16.0.preview.3",
        "panelizationSummary": {
          "containsEpubBubbles": false,
          "containsImageBubbles": false
        },
        "imageLinks": {
          "smallThumbnail": "http://books.google.com/books/content?id=_2gtBgAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
          "thumbnail": "http://books.google.com/books/content?id=_2gtBgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
        },
        "language": "pt-BR",
        "previewLink": "http://books.google.com.br/books?id=_2gtBgAAQBAJ&printsec=frontcover&dq=percy_jackson&hl=&cd=6&source=gbs_api",
        "infoLink": "https://play.google.com/store/books/details?id=_2gtBgAAQBAJ&source=gbs_api",
        "canonicalVolumeLink": "https://play.google.com/store/books/details?id=_2gtBgAAQBAJ"
      },
      "saleInfo": {
        "country": "BR",
        "saleability": "FOR_SALE",
        "isEbook": true,
        "listPrice": {
          "amount": 69.9,
          "currencyCode": "BRL"
        },
        "retailPrice": {
          "amount": 62.91,
          "currencyCode": "BRL"
        },
        "buyLink": "https://play.google.com/store/books/details?id=_2gtBgAAQBAJ&rdid=book-_2gtBgAAQBAJ&rdot=1&source=gbs_api",
        "offers": [
          {
            "finskyOfferType": 1,
            "listPrice": {
              "amountInMicros": 69900000,
              "currencyCode": "BRL"
            },
            "retailPrice": {
              "amountInMicros": 62910000,
              "currencyCode": "BRL"
            },
            "giftable": true
          }
        ]
      },
      "accessInfo": {
        "country": "BR",
        "viewability": "PARTIAL",
        "embeddable": true,
        "publicDomain": false,
        "textToSpeechPermission": "ALLOWED",
        "epub": {
          "isAvailable": true,
          "acsTokenLink": "http://books.google.com.br/books/download/Percy_Jackson_e_os_deuses_gregos-sample-epub.acsm?id=_2gtBgAAQBAJ&format=epub&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api"
        },
        "pdf": {
          "isAvailable": true,
          "acsTokenLink": "http://books.google.com.br/books/download/Percy_Jackson_e_os_deuses_gregos-sample-pdf.acsm?id=_2gtBgAAQBAJ&format=pdf&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api"
        },
        "webReaderLink": "http://play.google.com/books/reader?id=_2gtBgAAQBAJ&hl=&source=gbs_api",
        "accessViewStatus": "SAMPLE",
        "quoteSharingAllowed": false
      },
      "searchInfo": {
        "textSnippet": "Em Percy Jackson e os deuses gregos nosso querido semideus explica a versão da mitologia grega para a criação do mundo e dá aos leitores sua visão pessoal sobre quem é quem na Grécia Antiga, de Apollo a Zeus. “O dom de Percy, e ..."
      }
    },
    {
      "kind": "books#volume",
      "id": "JlWfzgEACAAJ",
      "etag": "VvRf0jw87DQ",
      "selfLink": "https://www.googleapis.com/books/v1/volumes/JlWfzgEACAAJ",
      "volumeInfo": {
        "title": "A batalha do Labirinto",
        "authors": [
          "Rick Riordan"
        ],
        "description": "\"O Monte Olimpo está em perigo. Cronos, o perverso titã que foi destronado e feito em pedaços pelos doze deuses olimpianos, prepara um retorno triunfal. O primeiro passo de suas tropas será atacar e destruir o campo de treinamento dos heróis, filhos de deuses com mortais, que desde a Grécia Antiga combatem na linha de frente em defesa dos olimpianos. Para assegurar que o refúgio de semideuses, o Acampamento Meio-Sangue, não seja invadido, Percy Jackson, Tyson, Annabeth e Grover são destacados para uma importante missão: deter as forças de Cronos antes que se aproximem do acampamento, no emaranhado de corredores do temido Labirinto de Dédalo - um interminável universo subterrâneo que, a cada curva, revela as mais aterrorizantes surpresas.\"--",
        "industryIdentifiers": [
          {
            "type": "ISBN_10",
            "identifier": "8580575427"
          },
          {
            "type": "ISBN_13",
            "identifier": "9788580575422"
          }
        ],
        "readingModes": {
          "text": false,
          "image": false
        },
        "pageCount": 367,
        "printType": "BOOK",
        "categories": [
          "Animals, Mythical"
        ],
        "maturityRating": "NOT_MATURE",
        "allowAnonLogging": false,
        "contentVersion": "preview-1.0.0",
        "panelizationSummary": {
          "containsEpubBubbles": false,
          "containsImageBubbles": false
        },
        "language": "pt-BR",
        "previewLink": "http://books.google.com.br/books?id=JlWfzgEACAAJ&dq=percy_jackson&hl=&cd=7&source=gbs_api",
        "infoLink": "http://books.google.com.br/books?id=JlWfzgEACAAJ&dq=percy_jackson&hl=&source=gbs_api",
        "canonicalVolumeLink": "https://books.google.com/books/about/A_batalha_do_Labirinto.html?hl=&id=JlWfzgEACAAJ"
      },
      "saleInfo": {
        "country": "BR",
        "saleability": "NOT_FOR_SALE",
        "isEbook": false
      },
      "accessInfo": {
        "country": "BR",
        "viewability": "NO_PAGES",
        "embeddable": false,
        "publicDomain": false,
        "textToSpeechPermission": "ALLOWED",
        "epub": {
          "isAvailable": false
        },
        "pdf": {
          "isAvailable": false
        },
        "webReaderLink": "http://play.google.com/books/reader?id=JlWfzgEACAAJ&hl=&source=gbs_api",
        "accessViewStatus": "NONE",
        "quoteSharingAllowed": false
      },
      "searchInfo": {
        "textSnippet": "O Monte Olimpo está em perigo."
      }
    },
    {
      "kind": "books#volume",
      "id": "4CqizgEACAAJ",
      "etag": "tJP5XjVGG2g",
      "selfLink": "https://www.googleapis.com/books/v1/volumes/4CqizgEACAAJ",
      "volumeInfo": {
        "title": "O Último Olimpiano",
        "authors": [
          "Rick Riordan"
        ],
        "description": "Os meios-sangues passaram o ano inteiro preparando-se para a batalha contra os Titãs, e sabem que as chances de vitória são pequenas. O exército de Cronos está mais poderoso que nunca, e cada novo deus ou semideus que se une à causa confere mais força ao vingativo titã. Enquanto os Olimpianos se ocupam de conter a fúria do monstro Tifão, Cronos avança em direção à cidade de Nova York, onde o Monte Olimpo está precariamente vigiado. Agora, apenas Percy Jackson e seu exército de heróis podem deter o Senhor do Tempo. Nesse quinto e último livro da série, o combate se acirra e o mundo que conhecemos está prestes a ser destruído. O destino da civilização está nas mãos do semideus anunciado na antiga profecia, e Percy está perto de completar dezesseis anos – a dúvida é: o herói será ou não capaz de tomar a decisão correta?\"--",
        "industryIdentifiers": [
          {
            "type": "ISBN_10",
            "identifier": "8580575435"
          },
          {
            "type": "ISBN_13",
            "identifier": "9788580575439"
          }
        ],
        "readingModes": {
          "text": false,
          "image": false
        },
        "pageCount": 383,
        "printType": "BOOK",
        "categories": [
          "Animals, Mythical"
        ],
        "maturityRating": "NOT_MATURE",
        "allowAnonLogging": false,
        "contentVersion": "preview-1.0.0",
        "panelizationSummary": {
          "containsEpubBubbles": false,
          "containsImageBubbles": false
        },
        "language": "pt-BR",
        "previewLink": "http://books.google.com.br/books?id=4CqizgEACAAJ&dq=percy_jackson&hl=&cd=8&source=gbs_api",
        "infoLink": "http://books.google.com.br/books?id=4CqizgEACAAJ&dq=percy_jackson&hl=&source=gbs_api",
        "canonicalVolumeLink": "https://books.google.com/books/about/O_%C3%9Altimo_Olimpiano.html?hl=&id=4CqizgEACAAJ"
      },
      "saleInfo": {
        "country": "BR",
        "saleability": "NOT_FOR_SALE",
        "isEbook": false
      },
      "accessInfo": {
        "country": "BR",
        "viewability": "NO_PAGES",
        "embeddable": false,
        "publicDomain": false,
        "textToSpeechPermission": "ALLOWED",
        "epub": {
          "isAvailable": false
        },
        "pdf": {
          "isAvailable": false
        },
        "webReaderLink": "http://play.google.com/books/reader?id=4CqizgEACAAJ&hl=&source=gbs_api",
        "accessViewStatus": "NONE",
        "quoteSharingAllowed": false
      },
      "searchInfo": {
        "textSnippet": "Os meios-sangues passaram o ano inteiro preparando-se para a batalha contra os Titãs, e sabem que as chances de vitória são pequenas."
      }
    },
    {
      "kind": "books#volume",
      "id": "QDnbbA9SukgC",
      "etag": "2gWBervi7eI",
      "selfLink": "https://www.googleapis.com/books/v1/volumes/QDnbbA9SukgC",
      "volumeInfo": {
        "title": "Percy Jackson e a Batalha do Labirinto",
        "authors": [
          "Rick Riordan"
        ],
        "publisher": "Leya",
        "publishedDate": "2012-04-20",
        "description": "Percy está prestes a começar o ano letivo numa escola nova. Ele já não esperava que essa experiência fosse muito agradável, mas quando teve de enfrentar um esquadrão de líderes de claque tão esfomeadas quanto demoníacas, imediatamente se apercebeu que tudo podia ficar muito pior. Nesse quarto volume da série Percy Jackson, o tempo está a esgotar-se e a batalha entre os Deuses do Olimpo e Cronos, o Senhor dos Titãs, está cada vez mais próxima. Mesmo o acampamento dos meio-sangues, o porto seguro dos heróis, torna-se vulnerável à medida que os exércitos de Cronos se preparam para atacar as suas fronteiras, até então impenetráveis. Para detê-los, Percy e seus amigos semideuses partirão numa jornada pelo Labirinto - um interminável universo subterrâneo que, a cada curva, revela as mais temíveis surpresas.",
        "industryIdentifiers": [
          {
            "type": "ISBN_13",
            "identifier": "9789724620862"
          },
          {
            "type": "ISBN_10",
            "identifier": "9724620867"
          }
        ],
        "readingModes": {
          "text": true,
          "image": true
        },
        "printType": "BOOK",
        "categories": [
          "Fiction"
        ],
        "maturityRating": "NOT_MATURE",
        "allowAnonLogging": true,
        "contentVersion": "1.6.5.0.preview.3",
        "panelizationSummary": {
          "containsEpubBubbles": false,
          "containsImageBubbles": false
        },
        "imageLinks": {
          "smallThumbnail": "http://books.google.com/books/content?id=QDnbbA9SukgC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
          "thumbnail": "http://books.google.com/books/content?id=QDnbbA9SukgC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
        },
        "language": "pt-BR",
        "previewLink": "http://books.google.com.br/books?id=QDnbbA9SukgC&printsec=frontcover&dq=percy_jackson&hl=&cd=9&source=gbs_api",
        "infoLink": "http://books.google.com.br/books?id=QDnbbA9SukgC&dq=percy_jackson&hl=&source=gbs_api",
        "canonicalVolumeLink": "https://books.google.com/books/about/Percy_Jackson_e_a_Batalha_do_Labirinto.html?hl=&id=QDnbbA9SukgC"
      },
      "saleInfo": {
        "country": "BR",
        "saleability": "NOT_FOR_SALE",
        "isEbook": false
      },
      "accessInfo": {
        "country": "BR",
        "viewability": "PARTIAL",
        "embeddable": true,
        "publicDomain": false,
        "textToSpeechPermission": "ALLOWED",
        "epub": {
          "isAvailable": true,
          "acsTokenLink": "http://books.google.com.br/books/download/Percy_Jackson_e_a_Batalha_do_Labirinto-sample-epub.acsm?id=QDnbbA9SukgC&format=epub&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api"
        },
        "pdf": {
          "isAvailable": true,
          "acsTokenLink": "http://books.google.com.br/books/download/Percy_Jackson_e_a_Batalha_do_Labirinto-sample-pdf.acsm?id=QDnbbA9SukgC&format=pdf&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api"
        },
        "webReaderLink": "http://play.google.com/books/reader?id=QDnbbA9SukgC&hl=&source=gbs_api",
        "accessViewStatus": "SAMPLE",
        "quoteSharingAllowed": false
      },
      "searchInfo": {
        "textSnippet": "Percy está prestes a começar o ano letivo numa escola nova."
      }
    },
    {
      "kind": "books#volume",
      "id": "rBxhmwEACAAJ",
      "etag": "h6YMTFfCuEQ",
      "selfLink": "https://www.googleapis.com/books/v1/volumes/rBxhmwEACAAJ",
      "volumeInfo": {
        "title": "Percy Jackson e os Olimpianos: Guia Definitivo",
        "authors": [
          "Rick Riordan"
        ],
        "publisher": "Intrínseca",
        "publishedDate": "2012-11-28",
        "description": "Vida de semideus não é fácil. Combater monstros, decifrar profecias e lançar-se em perigosas jornadas para salvar o mundo são tarefas rotineiras, e um herói não pode vacilar. Percy Jackson que o diga. O filho de Poseidon liderou as mais importantes missões de meios-sangues dos últimos tempos, e tudo o que ele aprendeu está nesse guia. Afinal, nunca se sabe quando o mundo estará novamente em perigo. Colorido, com fotos, mapas e ilustrações, o Guia definitivo mostra como descobrir quem é seu pai ou mãe divino, como detectar um sátiro e quais são os dez sinais de que talvez você seja um meio-sangue, além de informações sobre os personagens, as criaturas mitológicas — deuses, espíritos e monstros — e os lugares lendários que todo herói precisa saber de cor.",
        "industryIdentifiers": [
          {
            "type": "ISBN_10",
            "identifier": "8580572460"
          },
          {
            "type": "ISBN_13",
            "identifier": "9788580572469"
          }
        ],
        "readingModes": {
          "text": false,
          "image": false
        },
        "pageCount": 148,
        "printType": "BOOK",
        "categories": [
          "Juvenile Fiction"
        ],
        "averageRating": 5,
        "ratingsCount": 2,
        "maturityRating": "NOT_MATURE",
        "allowAnonLogging": false,
        "contentVersion": "preview-1.0.0",
        "imageLinks": {
          "smallThumbnail": "http://books.google.com/books/content?id=rBxhmwEACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api",
          "thumbnail": "http://books.google.com/books/content?id=rBxhmwEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"
        },
        "language": "pt-BR",
        "previewLink": "http://books.google.com.br/books?id=rBxhmwEACAAJ&dq=percy_jackson&hl=&cd=10&source=gbs_api",
        "infoLink": "http://books.google.com.br/books?id=rBxhmwEACAAJ&dq=percy_jackson&hl=&source=gbs_api",
        "canonicalVolumeLink": "https://books.google.com/books/about/Percy_Jackson_e_os_Olimpianos_Guia_Defin.html?hl=&id=rBxhmwEACAAJ"
      },
      "saleInfo": {
        "country": "BR",
        "saleability": "NOT_FOR_SALE",
        "isEbook": false
      },
      "accessInfo": {
        "country": "BR",
        "viewability": "NO_PAGES",
        "embeddable": false,
        "publicDomain": false,
        "textToSpeechPermission": "ALLOWED",
        "epub": {
          "isAvailable": false
        },
        "pdf": {
          "isAvailable": false
        },
        "webReaderLink": "http://play.google.com/books/reader?id=rBxhmwEACAAJ&hl=&source=gbs_api",
        "accessViewStatus": "NONE",
        "quoteSharingAllowed": false
      },
      "searchInfo": {
        "textSnippet": "Vida de semideus não é fácil."
      }
    }
  ]
}""";