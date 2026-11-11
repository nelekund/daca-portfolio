# Week 2: SQL Cleaning

**Meeskond:** Sales Analytics    
**Roll:** B – Customer Data Cleaner  
**Andmeallikas:** ´customers´ tabel (Supabase)   
**Link grupitööle:** [GitHub Sales Analytics Week 2](https://github.com/andres-assukyll/urbanstyle-sales-analytics/blob/main/week2/README.md)  

## Probleem

Nädal tagasi selgus, et enne kliendiandmete analüüsimist on vaja andmetabelit puhastada, sest tabel sisaldab klientide puhul ebajärjekindlaid linnanimesid ning duplikaatseid meiliaadresse. Need probleemid võivad anda ebatäpseid analüüsitulemusi ja eksitada ettevõtet klientide geograafilise jaotuse määramisel. Andmete puhastamine tagab tabeli usaldusväärse kasutamise asukohapõhistes võrdlustes ning efektiivse suunatud müügitegevuste kavandamise suurema kliendiarvuga linnades.

## 📁 Individuaalne töö

- [SQL puhastamisskript](week2_customers_cleaning.sql)

## 📝 Puhastamisraport

| Kategooria | Leitud probleeme |
| :--- | ---: |
| Puuduv e-mail | **380** |
| Duplikaatsed e-mailid | **128** |
| Ebajärjekindlad linnanimed | **12** |
| Puuduv eesnimi | 0 |
| Puuduv perenimi | 0 |
| **KOKKU** | **520** |

## 💡 Järeldus ja soovitus

Selgitada välja **puuduvate e-mailide põhjused** ja võimalusel **täiendada kontaktandmeid**, sest:

🔸online-tellimuse kinnitust meili teel ei ole võimalik puuduva e-mailiga kliendile saata;  
🔸tellimustega seotud probleemide korral ei saa ettevõte klienti meili teel teavitada;  
🔸puuduvad e-mailid piiravad tulevaste turunduskampaaniate potentsiaali.