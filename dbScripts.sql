﻿---------------------- SCENES TABLES -----------------
drop table endingendpoints;
drop table choices;
drop table scenes;
drop procedure addScene;
drop procedure getScene;
drop procedure updateScene;

drop procedure getChoicesFromScene;
drop procedure updateChoice;
drop procedure addChoice;

--select * from Scenes;

create table Scenes(
	sceneId int identity(1,1),
	textContent varchar(2500),
	textImage nvarchar(2500),
	ending varchar(4),
	sceneLocation varchar(6),
	primary key (sceneId)
);
go

create table Choices(
	choiceId int identity(1,1),
	precedent int foreign key references Scenes(sceneId),
	consequent int foreign key references Scenes(sceneId),
	optionText varchar(1000),
	primary key (choiceId)
)
go

create procedure addScene
(
	
	@content varchar(2500),
	@image varchar(2500) = 'none',
	@ending varchar(4) = 'none',
	@sceneLocation varchar(6)
)
as insert into Scenes (textContent, textImage, ending, sceneLocation) values (@content, @image, @ending, @sceneLocation);
go


create procedure getScene
(
	@id int
)
as select textContent, textImage, sceneId, ending, sceneLocation from Scenes where sceneId = @id;
go

--getScene 3;

create procedure updateScene
(
	@id int,
	@textContent varchar(2500)
)as update Scenes set textContent = @textContent where sceneId = @id
go


-------------------- CHOICES --------------------

--select * from Choices;

create procedure addChoice
(
	@pre int,
	@cons int,
	@content varchar(2500)
)
as insert into Choices (precedent, consequent, optionText) values (@pre, @cons, @content);
go

create procedure getChoicesFromScene
(
	@id int
)
as select consequent, optionText from Choices where precedent = @id;
go

--getChoiceFromScene 1

create procedure updateChoice
(
	@pre int,
	@cons int,
	@textContent varchar(2500)
)as update Choices set optionText = @textContent where precedent = @pre and consequent = @cons;
go

addScene 'You just woke up on the floor of your room. You feel sick and hungover. You probably shouldn''t have drank so much at this age... It''s so hard to even keep your eyes open, but you have a feeling that something is wrong. Don''t bother trying to remember what happened last night -- you won''t remember anything anyway after having that many glasses of wine. You were hanging out with Dom, things were heating up and then...', 
		@sceneLocation = 'room';
go
addScene 'You stumble into Dom''s unlocked room. Lying naked on the floor is his dead body, with a gold letter opener in his neck, and congealed blood in a puddle around him. The sick feeling in your stomach becomes ten times worse and your hands shake.', @sceneLocation = 'dom';
go
addScene 'In investigating the murder, the evidence is found to point towards you! After a tumultuous few weeks, you find yourself on trial for murder!!', @ending = 'bad',  @sceneLocation = 'dom';
go
go
addScene 'In a daze, you stagger around the room trying to piece together the situation. Everything is a blur, but a distinctive cigar stub and a pair of glittery earrings (not yours) manage to catch your attention. Someone has been here... but who? You notice and pick up a key card with ''E'' written on it in pencil. ',
@sceneLocation = 'dom'
go
addScene 'You''re back in the hallway and your head has cleared marginally. A gorgeous woman, seductive and somehow different to ordinary people, walks out of her room wearing a flowing blue sundress. Don''t worry, you''re prettier than her. She heads out to the deck, leaving behind a strangely familiar scent of perfume.',
 @sceneLocation = 'hall'
go
addScene 'You see the gorgeous woman from the hallway leaning over the railing, smoking the same kind of cigar that you found in Dom''s room, looking as though something is eating her from inside. Are you that brazen that you''d mention the murder?',
 @sceneLocation = 'deck'
go
addScene 'Her gaze pierces you, and she appears to be about to say something, before storming out of the deck. You continue your investigation but before long, the ship''s security guards are escorting you to a locked room and after a short, unfair interview with police, you''re on trial for murder.', @ending = 'bad',  @sceneLocation = 'deck';
go
addScene 'Heading back into the ballroom, one of the wait staff calls out to you.  
''Bet you had a good night, hey love?'' they jeer, with a funny look on their face.  
What happened? He glances over to the polaroids on the wall.  
Three of the pictures catch your eye -- one of you and Dom, one of Dom and the woman on the deck, and one of the three of you, with the woman looking murderously angry. A neatly written caption reads ''Look at Eleanor''s face!'' with an arrow pointing at the woman. 
You look at the key card in your pocket. If it''s not yours, and it''s not Dom''s, it must be hers.',
@sceneLocation = 'ball'
go
addScene 'You stand outside the slightly ajar door, your heart beating. You can see a shadowy figure inside, sitting on the bed. Perhaps her husband?!',
@sceneLocation = 'elroom'
go
addScene 'You walk inside and a whiskery man turns around. You recognise him from one of the polaroids. 
''Who are you?!'' he exclaims. Before you can say a word, he calls the ship''s reception. 
''Hello? Yes, this woman has BARGED into my room and I''d like her dealt with.'' 
You begin to rush to interrupt him, but a passing security guard notices the struggle and restrains you. Before you know it, you''re on trial for murder. 
', @ending = 'bad', @sceneLocation = 'elroom'
go
addScene 'Hurry up! You don''t have much time: you need to prove that cold-hearted witch killed Dom. He was so much kinder than her, and she couldn''t bear to see him talking to any other woman. Oh poor Dominic! You need to hurry up and get that man out of the room.',
@sceneLocation = 'ball'
go
addScene 'The receptionist told you that Eleanor''s husband is on his way. You don''t have much time.', @sceneLocation = 'ball'
go
addScene 'You have a couple of minutes til Eleanor''s husband comes back. There should be something here that proves that arrogant witch has done it. There are pillows and blanket on the couch and one side of the bed is untouched. Evidently things aren''t great between them.
You don''t have much time to waste.', @sceneLocation = 'elroom' 
go
addScene 'You find her phone sitting on her bedside table. The idiot forgot to take her phone with her. Not wise when you''ve just committed a murder. 
You need to look through the phone.', @sceneLocation = 'elroom'
go
addScene 'Damn it! The phone is locked. She doesn''t seem like the sort to put a complex password on her phone, however.', @sceneLocation = 'elroom'
go
addScene 'Her passport is sitting in the drawer. Surely she wouldn''t have her own birthday as the password...', @sceneLocation = 'elroom'
go
addScene 'It worked! 
You hurriedly scroll through her photos looking for anything incriminating',
@sceneLocation = 'elroom'
go
addScene 'WHAT? This isn''t possible!',
@sceneLocation = 'elroom'
go
addScene 'You find a series of drinks receipts all the way up to 4am last night. That can''t be right. When did she kill Dom? You need to find out the truth.',
@sceneLocation = 'elroom'
go
addScene 'While you''re looking underneath the bed, Eleanor''s husband comes back to the room. You recognise him from one of the polaroids. ''Who are you?!'' he exclaims. Before you can say a word, he calls the ship''s reception. ''Hello? Yes, this woman has BARGED into my room and I''d like her dealt with.'' You begin to rush to interrupt him, but a passing security guard notices the struggle and restrains you. Before you know it, you''re on trial for murder.
', @ending = 'bad', @sceneLocation = 'elroom'
go

addScene 'You sidle up to the reception window. A stack of paper lies on the desk with what looks like records of all the customers from last night. If only you had 20/20 vision! You''re tempted to grab it, but the receptionist is standing dangerously close.',
@sceneLocation = 'ball'
go
addScene 'You reach out and try to snatch the paper, but the reception turns around quick as a flash and snatches it right back. ''ExCUSE me? What do you think you''re doing, buddy?'' 
You begin to stammer out an excuse but before you can, he''s calling the security over. Before you know it, you''ve been locked up and put on trial for murder.  
', @ending = 'bad', @sceneLocation = 'ball'
go
addScene 'The receptionist frowns. ''I don''t know where you come from, buddy, but here things are more exxy. Four times as exxy''',
@sceneLocation = 'ball'
go
addScene '''Look buddy, that''s not going to work. Security! I need a hand!'' 
The security come over and after a quick discussion with the receptionist, you''ve been locked up in a secure room. Within hours the police have arrived and all the evidence is pointing to you. 
', @ending = 'bad', @sceneLocation = 'ball'
go
addScene 'He reluctantly gives in. ''Be quick.''', @sceneLocation = 'ball'
go
addScene 'You take a quick peek and see clear as day that Eleanor and her husband were in the ballroom buying drinks until very late last night. 
If she didn''t do it then who killed Dom? 
. 
. 
''Buddy, you dropped your phone last night when you were running in the hallway. You looked like you were flipping out, dude.'' 

You dropped your phone? You thought you went back to your room early. 

You open your phone and you see a stack of messages from your friend Lucie. 

''hey dude what''s going on???'' 
''dude are u ok?? talk to me!!!!!'' 
''ur scaring me!!!! hello ?????''', @sceneLocation = 'ball'
go
addScene '''Omg i didn''t wanna do it'' 
''Lucie i think i did something very bad text me back'' 
''What should i do now'' 
''They''re gonna find me helpppp'' 

Your head starts spinning again. You find yourself stumbling into Dom''s room in a daze as your memories gradually come back. The champagne, Dom, going back to his room, and he was so insistent. You resist but he becomes aggressive and then... the letter opener! It was self defense! You didn''t mean it!  
You collapse onto his bed filled with guilt. 
. 
. 
But it was self defense.  
. 
. 
He brought it upon himself. 
. 
. 
You''re not a bad person. 
. 
. 
After all, he deserved it.', @ending = 'good', @sceneLocation = 'ball'
go
addScene '''What do you want?''  
She sounds pissed at you.  
''You enjoying the cruise?'' you enthusiastically enquire. 
''I was enjoying it more before you showed up'' 
What did you do?', @sceneLocation = 'deck'
go
addScene '''What are you talking about?'' you ask, puzzled.
One of the staff members walks in. ''Here is your bloody Mary, Ms Eleanor''

Eleanor!! Like the E on the card you found in Dom''s room.
What was Eleanor doing in Dom''s room?
Eleanor takes the drink and turns her piercing gaze to you.
''Don''t act like you don''t know. I was having a lovely night before you barged in...''
She takes a sip of her drink and looks at you disgustedly.
''...and Dom decided he liked the look of you.''
', @sceneLocation = 'deck'
go
addScene 'You slowly start to recollect that you and Dom were chatting for hours in the ballroom. 
''Slow down, we were just having fun!'' 
''That''s how it starts! I was going to leave my damn husband for him!'' 
The silence could be cut with a knife.', @sceneLocation = 'deck'
go
addScene 'You decide it''s time to accuse her of Dom''s murder. 
''Look witch, I know you did it.'' 
''...did what?'' 
''Murdered Dom! You couldn''t handle that he liked me better! And you were dumb enough to leave evidence all over his room!'' 
''I-I didn''t! Why would I do that?! We have to go to the police.'' 
''I don''t think we should'', you reply. You have a bad feeling that you''re going to look like a suspect. 
''Of course we should. I''m going to call them right right now.''', @sceneLocation = 'deck'
go
addScene 'You follow her to the reception and stand while she makes the phone call. The police come and the investigation goes on, before suddenly you are arrested as the prime suspect. 
', @ending = 'bad', @sceneLocation = 'ball'
go
addScene '''You DEFINITELY shouldn''t call them. Your earrings and cigars were all over the room!'' 
''I didn''t kill him! I can prove it. I was in the ballroom all night with my husband.'' 
Eleanor reaches for her bag and shows you the receipts of the drinks she bought late last night with her husband. 
''I just don''t get it. Why, why. Why would anyone kill Dom?''',
@sceneLocation = 'deck'
go
addScene 'You leave her on the verge of tears in the ballroom while you walk back to Dom''s room. A smell of death and depravity greets you at the door. Dom is still where you left him, but the blood is almost completely dry now.',
@sceneLocation = 'dom'
go
addScene 'While searching you notice a GoPro on Dom''s table, pointed at the bed. Curious.',
@sceneLocation = 'dom'
go 
addScene 'The video begins with Dom walking back to you, sitting on the bed. The two of you begin making out. You had no idea he was recording. What a creep! Things start to heat up when he becomes too aggressive. You try to push him away but he doesn''t stop. 
Reaching out for anything, your hand closes around the gold letter opener and brings it up to his head. Blood spurts out of his neck across the room.', @sceneLocation = 'dom'
go
addScene 'You head back out to the reception, heart pounding, and ask to use the phone to call the police. While they show up and investigate, you sneakily drop the GoPro over the railing. 
. 
. 
. 
It''s going to be you and Dom''s little secret. ', @ending = 'good', @sceneLocation = 'dom'
go
addScene 'Very moral of you. You head back out to the reception, heart pounding, and ask to use the phone to call the police. They show up to investigate, and arrest you as a suspect. You came here to have fun, and now you live behind bars. 
', @ending = 'bad', @sceneLocation = 'ball'
go

addScene 'The two of you walk back to Dom''s room. A smell of death and depravity greets you at the door. Dom is still where you left him, but the blood is almost completely dry now.',
@sceneLocation = 'dom'
go
addScene 'While searching you notice a GoPro on Dom''s table, pointed at the bed. Curious.',
@sceneLocation = 'dom'
go
addScene 'The video begins with Dom walking back to you, sitting on the bed. The two of you begin making out. You had no idea he was recording. What a creep! Things start to heat up when he becomes too aggressive. You try to push him away but he doesn''t stop. Reaching out for anything, your hand closes around the gold letter opener and blood spurts out of his neck across the room. 
There is a pause, before Eleanor looks at you in fear and starts to back out of the room.',
@sceneLocation = 'dom'
go
addScene 'While she struggles with the door, you tug the letter opener out of Dom''s neck, accompanied by a dribble of thickened blood. As she panics and tears at the door handle, you run up behind her and plunge the letter opener into her neck. 
You wash your hands thoroughly and head back out to the reception, finally feeling steady, and ask to use the phone to call the police. While they show up and investigate, you sneakily drop the GoPro over the railing. 

It needed to be done.', @ending = 'good', @sceneLocation = 'dom'
go
addScene 'Very moral of you. You head back out to the reception, heart pounding. Eleanor asks to use the phone to call the police. They show up to investigate, and arrest you as a suspect. You came here to have fun, and now you live behind bars. 
', @ending = 'bad', @sceneLocation = 'ball'
go


--Start adding choices--
addChoice 1, 2, 'Go check on Dom';
go
addChoice 2, 3, 'Report the murder';
go
addChoice 2, 4, 'Look around Dom''s room';
go
addChoice 4, 5, 'Leave Dom''s room';
go
addChoice 5, 8, 'Go the ballroom';
go
addChoice 5, 6, 'Follow her out to the deck';
go
updateChoice @textContent = 'Follow her out to the deck', @pre = 5, @cons = 6;
go
addChoice 6, 7, 'Tell her about Dom''s murder';
go
addChoice 6, 8, 'Go the the Ballroom';
go
addChoice 8, 9, 'Go to Eleanor''s room';
go
addChoice 9, 10, 'Go inside right away';
go
addChoice 9, 11, 'Go back out to reception';
go
addChoice 11, 12, 'Ask receptionist to page Eleanor''s husband';
go
addChoice 12, 13, 'Go back to Eleanor''s room';
go
addChoice 13, 14, 'Search Eleanor''s room';
go
addChoice 14, 15, 'Look through the phone';
go
addChoice 15, 16, 'Search Eleanor''s room for clues to open her phone';
go
addChoice 16, 17, 'Try Eleanor''s birthday';
go
addChoice 17, 18, 'Check Eleanor''s email';
go
addChoice 18, 19, 'Huh???';
go
addChoice 19, 20, 'Keep searching';
go
addChoice 19, 21, 'Head to reception';
go
addChoice 21, 23, 'Bribe $50';
go
addChoice 21, 25, 'Bribe $200';
go
addChoice 21, 22, 'Try to take the paper';
go
addChoice 23, 24, 'Bribe $50 (again)';
go
addChoice 23, 25, 'Bribe $200';
go
addChoice 25, 26, 'Read the receipts list quickly';
go
addChoice 26, 27, 'Check the messages you sent last night';
go

--updateChoice @textContent = 'Look around the room', @pre = 1, @cons = 2;
--Eleanor's branch starts here--

addChoice 6, 28, 'Talk to the woman';
go
updateChoice @textContent = 'Talk to her', @pre = 6, @cons = 28;
go
addChoice 28, 29, 'Talk to the woman again';
go
addChoice 28, 8, 'Go to the Ballroom';
go
addChoice 29, 30, 'Keep talking to Eleanor';
go
addChoice 29, 8, 'Go to the Ballroom';
go
addChoice 30, 31, 'Accuse her of Dom''s murder';
go
addChoice 30, 8, 'Go to the Ballroom';
go
addChoice 31, 32, 'Concede and go with her to call the police';
go
addChoice 31, 33, 'Threaten her with the evidence against her';
go
addChoice 33, 34, 'Suggest to go and check Dom''s room while Eleanor is in shock';
go
addChoice 33, 39, 'Go with Eleanor to check Dom''s room';
go
addChoice 34, 35, 'Search thoroughly';
go
addChoice 35, 36, 'Play the most recent video on the GoPro';
go
addChoice 36, 37, 'Get rid of the GoPro';
go
addChoice 36, 38, 'Confess';
go
addChoice 39, 40, 'Search thoroughly with Eleanor';
go
addChoice 40, 41, 'Play the most recent video on the GoPro with Eleanor';
go
addChoice 41, 42, 'Grab the letter opener and stab Eleanor';
go
addChoice 41, 43, 'Confess';
go


update Scenes set textImage = '
                 __ /___
           _____/______|
   _______/_____\_______\_____
   \   o  o  o    < < <       |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
' where sceneId = 1;
go

update Scenes set textImage = '
                   (  )/  
                    )(/
 ________________  ( /)
()__)____________)))))   
' where sceneId = 6;
go

update Scenes set textImage = '     
      

                    .--.  
                   / _(c\   .-.     __
                  | / x  `-;   \`-``  `\______
                  \_\x / __/ )  /  )   |      \--,
                  | \`""`__-/ .`--/   /--------\  \
 ' where sceneId = 2;
 go

update Scenes set textImage = '
0================================================0
|        :            `\"/`  ______     :     .. |
|        :     mmmmmmm  V   |--%%--|    :   .`|| |
|        :     |  |  |      |-%%%%-|    :  |  || |
|        :     |--|--| @@@  |=_||_=|    :  I  || |
|        :     |__|__|@@@@@ |_\__/_|    :  |  || |
|        :             \|/   ____       :  |  || |
|        :;;       .```(_)```\__/````:  :  |  || |
|        :||___   :================:`|  :  | 0+| |
|        :||===)  | |              | |  :  |  || |
|        ://``\\__|_|______________|_|__:  I  || |
|      .`/`    \` | `              | `   `.|  || |
|    .`           |    _____       |       `. || |
|  .`                 |     |                `|| |
|.`                   |  E  |                  `.|
|                     |_____|                   .|
0================================================0
' where sceneId = 4
 go

update Scenes set textImage = '
               ,{{}}}}}}.
              {{{{{}}}}}}}.
             {{{{  {{{{{}}}}
            }}}}} _   _ {{{{{
            }}}}  0   0  }}}}}
           {{{{C    ^    {{{{{
          }}}}}}\   =  /}}}}}}
         {{{{{{{{;.___.;{{{{{{{{
         }}}}}}}}})   (}}}}}}}}}}
        {{{{}}}}}:   :{{{{{{{{{{
        {{{}}}}}}  `@` {{{}}}}}}}
         {{{{{{{{{    }}}}}}}}}
           }}}}}}}}  {{{{{{{{{
            {{{{{{{{  }}}}}}
               }}}}}  {{{{
                {{{    }}' where sceneId = 6;
 go

 update Scenes set textImage = '
              {{{{{}}}}}}}.
             {{{{  {{{{{}}}}
            }}}}} \.  ./{{{{{
            }}}} (0) (0) }}}}}
           {{{{C    _    {{{{{
          }}}}}}\  (_)  /}}}}}}
         {{{{{{{{;.___.;{{{{{{{{
         }}}}}}}}})   (}}}}}}}}}}
        {{{{}}}}}:   :{{{{{{{{{{
        {{{}}}}}}  `@` {{{}}}}}}}
         {{{{{{{{{    }}}}}}}}}
           }}}}}}}}  {{{{{{{{{
            {{{{{{{{  }}}}}}
               }}}}}  {{{{
                {{{    }} ' where sceneId = 28;
go

 update Scenes set textImage = '
                   o           o 
                      o   o    
                         o         o

                     o       o  o 
                  ________._____________
                  |   .                |
                  |^^^.^^^^^.^^^^^^.^^^|
                  |     .   .   .      |
                   \      . . . .     /
                     \     .  .     / 
                       \    ..    / 
                         \      /
                           \  /
                            \/
                            ||
                            ||
                            ||
                            ||
                            ||
                      ============== ' where sceneId = 29;
go

update Scenes set textImage = '
`.                      |
  `.                    |       ___________________             ____________
    `.                  |      |  _______________  |           |.----------.|
 .    `.                |      | |               | |           ||     |>   ||
 |`.    `.              |      | |   ___   ___   | |           || O  /|    ||
 |. `.    `.____________|      | |  |   | |   |  | |           ||   /_(    ||
 |||.|     |            |      | |  |   | |   |  | |           || .___|__  ||
 |||||     |            |      | |  |   | |   |  | |           ||~~\____|~~||
 |||||     |            |      | |  |   | |   |  | |           || ~  ~    ~||
 |||||     |            |      | |  |   | |   |  | |           |:__________:|
 |||||     |   *    *   |      | |  |   | |   |  | |           `------------`
 |||||     |    *..**   |      | |  `---___---`__| |
 |  `|     |     _:_    |      | |    |_____| |__= |
 |. ()     |    (   )   |      | |   ___   ___ ()| |
 |||||     |     ) (    |      | |  |   | |   |  | |
 |||||     | ===========|      | |  |   | |   |  | |
 |||||     |   | |    | |      | |  |   | |   |  | |
 |||||     |   | |    | |      | |  |   | |   |  | |
 |||||    _|___|_|____|_|      | |  |   | |   |  | |
 |||:|--"" |___|_|____|_|      | |  `---` `---`  | |
 _____________________________________________________ ' where sceneId = 5;
go

update Scenes set textImage = '
______________________________________
|            .---.					
|           / :""|       {{}}}}.	|
|           |:`..|      {{{{{{{}}	|
|            \  _|       /o   }}}}}	|
|             ) /        \_  {{{{{	|
|            /`\\          \(`}}}}	|
|           || |Y|        //`\{{{	|
|           || |.|       / | ||}}}	|
|           || |.|       \ | |{{{	|
| ____________________________________' where sceneId = 8;
go	


update Scenes set textImage = '
                     __.---`|					
              ___.---`      |				  
      ___.---`              |				   
 _.--`              \\\     |				 
 |                  .. |    |				   
 |                  U. |    |				   
 |                  __=__   |
 |                 |     \  |
 |                 |.    \\-`-.________________________________________
 |                 ||\    \\__.>-._							
 |                 \\_\__.--`       `--._				  
 L-._   _____.----`                    `--.__            
  |  `-<_                                    `-.__       
  |      `-.                                     _>-.     
  L.        `-._                          ___.--`   |
   | `-._        `-._                __.--`          |
         `-._        `-.       __.--`            _.--`
             `-._       `-._.-`             _.--`    |
                 `-.       |           _.--`
                    `-.    |      _.--`        
                       `-. | _.--`			 
                          `|`				 
                           |' where sceneId = 9;
go	

update Scenes set textImage = '
                               __/
                               \,/
                               _|___
                      ...,    [_____]
                     (,,,,,      _|//
                     , , ;;      ( /
                    <    D        =o
                    |.   /       /\|
                _____|><|_______/o /
               / `==| :: |==`  <  /
              /  \  <    >  /____/
             /  _/\ | :: | /
              \  ||_|____|/
               |o| |     |
               ( \ / _|_ \\ 
                 |    |   |
                 |    |   | 'where sceneId = 11;
go

update Scenes set textImage = '				 
                           ( who page me? )
                            (            )
                             "----------"
                               ()
                 \\\\\       O
                |  (0)0)   o
                C     U
                 \   =|
                  \__/
                <____Y>
               |   |  :|
               |   |  :|
               |___|  :|
                | |   :| 'where sceneId = 12;
go

update Scenes set textImage = '	
  ___.--------```````:```````--------.___
 (   |               :               |   )
  \ ,;,,,            :               |  /
   |\%%%%\___________:__________/~~~~~/|
  / ,\%%%%\          |         / @*@ /,|
 /_ / `````          |         ~~~~~~ \__L
(@l)                 |                 (@l)
 ||__________________|__________________||
 ||_____________________________________||
/_|_____________________________________|_\ 'where sceneId = 13;
go

update Scenes set textImage = '
           _      ()              ()      
          / \     ||______________||    
         /___\    |                |       
           |      |      ~@@~      |       
          (_)     |_______  _______|      ______
       ___/_\___  {_______}{_______}  ___|iPhone|___
        |__~__|   %%%%%%%%%%%%%%%%%%   |____~____ |
     ___|_____|__%%%%%%%%%%%%%%%%%%%%  |____~____ |
        |     | %%%%%%%%%%%%%%%%%%%%%% |          |
         `=====%%%%%%%%%%%%%%%%%%%%%%%%=======`
        `=====%%%%%%%%%%%%%%%%%%%%%%%%%%=======`
       `=====%%%%%%%%%%%%%%%%%%%%%%%%%%%%=======`
      `=====/||||||||||||||||||||||||||||\=======`
     `======||||||||||||||||||||||||||||||========`
    `=======||||||||||||||||||||||||||||||=========`
   `================================================`
  `==================================================`
	   .--.		================================`
	 .`    `.	=================================`	
	 | ^__^ |	==================================`
	 `.____.`	===================================`		
`=============================================================`'where sceneId = 14;
go

update Scenes set textImage = '
 ______________________
| o__________________  |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| Press home to unlock |
| _________(_)________ |
|______________________|'where sceneId = 15;
go

update Scenes set textImage = '
    /
   /
  /____________________
  |________  __________
  /_____  /||   |
 |".___."| ||   |
 |_______|/ |   |
  || .___."||  /
  ||_______|| /
  |_________|/'where sceneId = 16;
go

update Scenes set textImage = '
     ((())))
   ))))) _()__
  ))))=-[.].] 
 ))))(    _\    
))))))   __|  __
))))) \  _/  |  |
))).--`--`-. |  | 
))/ __      `|__|
_(____nm______ww 
'where sceneId = 17;
go

update Scenes set textImage = '
      ()))))))))  
     (((((( ) )))  ?!
   ()))) [o].[o]
  ())(,    __  |
 ()))))   (__) /
(( )))))._____/
((( ))))   (
;;;;;;;;)
 'where sceneId = 18;
go

update Scenes set textImage = '
      .======================================.
      | ___ ___ ___ RECEPTION     _   _   _  |
      | \_/ \_/ \_/ C|||C|||C||| |-| |-| |-| |
      | _|_ _|_ _|_  ||| ||| ||| |_| |_| |_| |
      `======================================`
								
           .:.                    
          C|||           |".--------."|           
        ___|||___________|__Receipts__|_____
       [____________________________________]
        |   ____    ____    ____    ____   |
        |  (____)  (____)  (____)  (____)  |
        |  |    |  |    |  |    |  |    |  |
        |  |    |  |    |  |    |  |    |  |
        |  |    |  |    |  |    |  |    |  |
        |  |____|  |____|  |____|  |____|  |
        |  I====I  I====I  I====I  I====I  |
        |  |    |  |    |  |    |  |    |  |'where sceneId = 21;
go

update Scenes set textImage = '
+---------------------------------+
|                                 |
|           CRUISE BAR            |
|                                 |
|        12 Pacific Avenue        |
|       Melbourne, VIC 3000       |
|         (66) xxx-xxxx           |
|              4 A.M.             |
|  Prosecco               $25.00  |
|  Chateau Margaux        $55.00  |
|  Heidsieck              $49.00  |
|  Chateau Cheval Blanc	  $45.00  |
|  TOTAL                 $xxx.xx  |
|  Credit                $xxx.xx  |
|  Change                $20.00   |
|          THANK YOU!             |
+---------------------------------+'where sceneId = 19;
go

update Scenes set textImage = '
XXXXXXXXXXXXXXXXX FEDERAL RESERVE NOTE XXXXXXXXXXXXXXXXXX
XXX  XX                                           XXX  XX
XXXX XX  -------       ------------               XXXX XX
XXXX XX              /   jJ===-\    \             XXXX XX
XXXXXX              /   jJ - -  L    \             XXXXXX
XXXXX               |   JJ  |   X    |              XXXXX
XXX        $50      |   JJ ---  X    |      $50       XXX
XXX                 |   J|\    /|    |                XXX
XXX                 |   /  |  |  \   |                XXX
XXX                 |  |          |  |                XXX
XXX                 \ /            \ /                XXX
X  XX                \ ____________ /               X  XX
XX XXX                  FITTY DOLLAR               XXX XX
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'where sceneId = 23;
go

update Scenes set textImage = '               	   
             { .--.....-.}
            { {         }}
            ||           ||
            ||  ___  ___ |]
            /`    0  \ 0 |
            \_       _)  |
             |     ____  ;
             | \   `--` /
          _./\  `.____.`
       _.:::| `\   >< |\:._
     .::::::::`\ `.   / /::::.
    /:::::::::::|/::\/:\|:::::\'where sceneId = 25;
go

update Scenes set textImage = ' 
    _________________________
   |           __            |
   |         .`  `.          |
   |         :    :          |
   |         `.__.`          |
   |         SAMSANG         |
   | .---------------------. |
   | |                     | |
   | |  ~~~~~~~~~          | |
   | |  ~~~~~~~~~          | |
   | |  ~~~~~              | |
   | |  ....Hello????      | |
   | |                     | |
   | |                     | |
   | `---------------------` |
   |                         |'where sceneId = 26;
go

update Scenes set textImage = '  
            .-.								
           (/^\)       .-.				
           (\ /)      //^\\				   
           .-`-.     { \ / }   .....	  
          /(_,_)\    {.-`-.}			 
          \\) (//    /\_ _/\			
           /   \     \\) (//		   	
           |   |      /   \			  
           |___|      |   |					 
		   'where sceneId = 30;
go

update Scenes set textImage = ' 
                    ..(())..
                ..((((((()))))..
              .((((((((((())))))).
            .((((((((((()))))))))).	I KNOW what you did!!
           ((((((((((((()))))))))))).	
         (((((((((((^"  "^))))))))))))		
        ((((((((("            ")))))))))  
       ((((((((`.gfbn._  _.nfbs.`))))))))
      ((((((((( ...__      __... )))))))))
     (((((((((( `. o :    : o .` ))))))))))
     ((((((((((   "-`      `-"   )))))))))))
    (((((((((((         :        ))))))))))))
    (((((((((((          .       ))))))))))))
   (((((((((((        ._ `       ))))))))))))
   (((((((((((                   ))))))))))))
   (((((((((((       .=-._       )))))))))))))
  ((((((((((((       ".-""       )))))))))))))
  (((((((((((((.-._          _.-.))))))))))))))

   'where sceneId = 31;
go



update Scenes set textImage = ' 
  .-"""-.
 | _   _ |
 ](_` `_)[
 `-. N ,-` 
   |   |
   `---`												
                    .--.  
                   / _(c\   .-.     __
                  | / x  `-;   \`-``  `\______
                  \_\x / __/ )  /  )   |      \--,
   _______________| \`""`__-/ .`--/   /--------\  \________________
'where sceneId = 39;
go

update Scenes set textImage = '
 ___________________________________________________________________ 
|* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *|
|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
|   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   |
| *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   * |
|   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   |
| *  _*   *   *   *   *   *   *   *   *   *   *   *   *   *   *   * |
|===[_]=============================================================|
|___(_)___  _______________      |__(_)_[]|      _______________    |
||___~___| |_______________| ____|__GoPro_|__   |    *     *    |   |
||___~___| {_______________}  |_____ 0______|  /|_______________|\  |
||___~___|_%%%%%%%%%%%%%%%%%__|______0______|_()/_______________\()_|
=|/=====\|%%%%%%%%%%%%%%%%%%%=|/===========\|==|_________________|=~
=========%%%%%%%%%%%%%%%%%%%%%=================|_________________|==~
========%%%%%%%%%%%%%%%%%%%%%%%======================================~
=======%%%%%%%%%%%%%%%%%%%%%%%%%======================================~
======%%%%%%%%%%%%%%%%%%%%%%%%%%%======================================~
=====%%%%%%%%%%%%%%%%%%%%%%%%%%%%%======================================~
====/|||||||||||||||||||||||||||||\======================================~
====|||||||||||||||||||||||||||||||=======================================~'where sceneId = 35;
go

update Scenes set textImage = '
 ___________________________________________________________________ 
|* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *|
|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
|   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   |
| *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   * |
|   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   |
| *  _*   *   *   *   *   *   *   *   *   *   *   *   *   *   *   * |
|===[_]=============================================================|
|___(_)___  _______________      |__(_)_[]|      _______________    |
||___~___| |_______________| ____|__GoPro_|__   |    *     *    |   |
||___~___| {_______________}  |_____ 0______|  /|_______________|\  |
||___~___|_%%%%%%%%%%%%%%%%%__|______0______|_()/_______________\()_|
=|/=====\|%%%%%%%%%%%%%%%%%%%=|/===========\|==|_________________|=~
=========%%%%%%%%%%%%%%%%%%%%%=================|_________________|==~
========%%%%%%%%%%%%%%%%%%%%%%%======================================~
=======%%%%%%%%%%%%%%%%%%%%%%%%%======================================~
======%%%%%%%%%%%%%%%%%%%%%%%%%%%======================================~
=====%%%%%%%%%%%%%%%%%%%%%%%%%%%%%======================================~
====/|||||||||||||||||||||||||||||\======================================~
====|||||||||||||||||||||||||||||||=======================================~'where sceneId = 40;
go

update Scenes set textImage = '
o~@~@~@~@~@~@~@~o  
| !!!!!!}!{!!!!!!                            
| !!!!!} | {!!!!!                               
| !!!!}  |  {!!!!      
| !!!`   |   `!!!     
|=~@~----+----~@~
| !!!    |    !!!   
| !!!    |    !!!					  
| !!!____|____!!!					  
| !!!=========!!!		
|_!!!_________!!!	               
                   (  )
                    )(
 ________________  ( )
()__)____________)))))

'where sceneId = 33;
go

update Scenes set textImage = ' 
  .-"""-.
 | _   _ |
 ](_` `_)[
 `-. N ,-` 
   |   |
   `---`												
                    .--.  
                   / _(c\   .-.     __
                  | / x  `-;   \`-``  `\______
                  \_\x / __/ )  /  )   |      \--,
   _______________| \`""`__-/ .`--/   /--------\  \________________
'where sceneId = 34;
go

update Scenes set textImage = '
8888888888888888888888888888888888888888888888888888 
88888888888888888888888888888888oo888888888888888888 
88888888888888888888 88888888o``````o888888888888888 
888888888888888888     88888o[O]  [O]o88888888888888 
88888888888888888888 88888888        888888888888888 
88888888888888888888 888888888        88888888888888 
88888888888888888888 8oo```oo88888o```````8888888888 
88888888888888888888 o       o888o`````````o88888888 
8888888888888oo```o88  x  x  o88o```````````o8888888 
8888888888oo````````oo       88o`````````````o888888 
8888888o`````````````o88ooo888o```````````````o88888 
888o``````````````````o888888``````o8o`````````o8888 
8o````````````````````````````````8888o`````````o888 
8````````````o88888`````````````o888888`````````o888 
8```````````o8888888ooo`ooooooo88888o```````````o888 
8``````````````o88888888888888888o``````````````o888 
8``````oo`````````8888888888888o```````o888`````o888 
8`````o8888oo``````o88888888888o`````888888o````o888 
8`````o8888888o`````o8888888888o````o888888o````o888 
o`````o88888888o`````o888888888o````o888888o`````oo8 
``````8888888888o`````o88888888`````o8888888```````8 
```oo8888888888888``````8888888`````o888888888o````8
o888888888888888888``````888888`````o8888888888888`8 
88888888888888888888o````o88888o````o888888888888888 
888888888888888888888o``o8888888o``o8888888888888888
8888888888888888888888888888888888888888888888888888
'where sceneId = 36;
go

update Scenes set textImage = '
8888888888888888888888888888888888888888888888888888 
88888888888888888888888888888888oo888888888888888888 
88888888888888888888 88888888o``````o888888888888888 
888888888888888888     88888o[O]  [O]o88888888888888 
88888888888888888888 88888888        888888888888888 
88888888888888888888 888888888        88888888888888 
88888888888888888888 8oo```oo88888o```````8888888888 
88888888888888888888 o       o888o`````````o88888888 
8888888888888oo```o88  x  x  o88o```````````o8888888 
8888888888oo````````oo       88o`````````````o888888 
8888888o`````````````o88ooo888o```````````````o88888 
888o``````````````````o888888``````o8o`````````o8888 
8o````````````````````````````````8888o`````````o888 
8````````````o88888`````````````o888888`````````o888 
8```````````o8888888ooo`ooooooo88888o```````````o888 
8``````````````o88888888888888888o``````````````o888 
8``````oo`````````8888888888888o```````o888`````o888 
8`````o8888oo``````o88888888888o`````888888o````o888 
8`````o8888888o`````o8888888888o````o888888o````o888 
o`````o88888888o`````o888888888o````o888888o`````oo8 
``````8888888888o`````o88888888`````o8888888```````8 
```oo8888888888888``````8888888`````o888888888o````8
o888888888888888888``````888888`````o8888888888888`8 
88888888888888888888o````o88888o````o888888888888888 
888888888888888888888o``o8888888o``o8888888888888888
8888888888888888888888888888888888888888888888888888
'where sceneId = 41;
go

select * from Choices
go

update Scenes set textImage = '
______________________________________
|            .---.					
|           / :""|       {{}}}}.	|
|           |:`..|      {{{{{{{}}	|
|            \  _|       /o   }}}}}	|
|             ) /        \_  {{{{{	|
|            /`\\          \(`}}}}	|
|           || |Y|        //`\{{{	|
|           || |.|       / | ||}}}	|
|           || |.|       \ | |{{{	|
| ____________________________________' where sceneId = 8;
go	


update Scenes set textImage = '
                     __.---`|					
              ___.---`      |				  
      ___.---`              |				   
 _.--`              \\\     |				 
 |                  .. |    |				   
 |                  U. |    |				   
 |                  __=__   |
 |                 |     \  |
 |                 |.    \\-`-.________________________________________
 |                 ||\    \\__.>-._							
 |                 \\_\__.--`       `--._				  
 L-._   _____.----`                    `--.__            
  |  `-<_                                    `-.__       
  |      `-.                                     _>-.     
  L.        `-._                          ___.--`   |
   | `-._        `-._                __.--`          |
         `-._        `-.       __.--`            _.--`
             `-._       `-._.-`             _.--`    |
                 `-.       |           _.--`
                    `-.    |      _.--`        
                       `-. | _.--`			 
                          `|`				 
                           |			   
	   .--.
	 .`    `.
	 | ^__^ |
	 `.____.`
	 		   
	   ' where sceneId = 9;
go	

update Scenes set textImage = '
                               __/
                               \,/
                               _|___
                      ...,    [_____]
                     (,,,,,      _|//
                     , , ;;      ( /
                    <    D        =o
                    |.   /       /\|
                _____|><|_______/o /
               / `==| :: |==`  <  /
              /  \  <    >  /____/
             /  _/\ | :: | /
              \  ||_|____|/
               |o| |     |
               ( \ / _|_ \\ 
                 |    |   |
                 |    |   | 'where sceneId = 11;
go

update Scenes set textImage = '				 
                           ( who page me? )
                            (            )
                             "----------"
                               ()
                 \\\\\       O
                |  (0)0)   o
                C     U
                 \   =|
                  \__/
                <____Y>
               |   |  :|
               |   |  :|
               |___|  :|
                | |   :| 'where sceneId = 12;
go

update Scenes set textImage = '	
  ___.--------```````:```````--------.___
 (   |               :               |   )
  \ ,;,,,            :               |  /
   |\%%%%\___________:__________/~~~~~/|
  / ,\%%%%\          |         / @*@ /,|
 /_ / `````          |         ~~~~~~ \__L
(@l)                 |                 (@l)
 ||__________________|__________________||
 ||_____________________________________||
/_|_____________________________________|_\ 'where sceneId = 13;
go

update Scenes set textImage = '
           _      ()              ()      
          / \     ||______________||    
         /___\    |                |       
           |      |      ~@@~      |       
          (_)     |_______  _______|      ______
       ___/_\___  {_______}{_______}  ___|iPhone|___
        |__~__|   %%%%%%%%%%%%%%%%%%   |____~____ |
     ___|_____|__%%%%%%%%%%%%%%%%%%%%  |____~____ |
        |     | %%%%%%%%%%%%%%%%%%%%%% |          |
         `=====%%%%%%%%%%%%%%%%%%%%%%%%=======`
        `=====%%%%%%%%%%%%%%%%%%%%%%%%%%=======`
       `=====%%%%%%%%%%%%%%%%%%%%%%%%%%%%=======`
      `=====/||||||||||||||||||||||||||||\=======`
     `======||||||||||||||||||||||||||||||========`
    `=======||||||||||||||||||||||||||||||=========`
   `================================================`
  `==================================================`
	   .--.		================================`
	 .`    `.	=================================`	
	 | ^__^ |	==================================`
	 `.____.`	===================================`		
`=============================================================`'where sceneId = 14;
go

update Scenes set textImage = '
 ______________________
| o__________________  |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| |~~~~~~~~~~~~~~~~~~| |
| Press home to unlock |
| _________(_)________ |
|______________________|'where sceneId = 15;
go

update Scenes set textImage = '
    /
   /
  /____________________
  |________  __________
  /_____  /||   |
 |".___."| ||   |
 |_______|/ |   |
  || .___."||  /
  ||_______|| /
  |_________|/'where sceneId = 16;
go

update Scenes set textImage = '
     ((())))
   ))))) _()__
  ))))=-[.].] 
 ))))(    _\    
))))))   __|  __
))))) \  _/  |  |
))).--`--`-. |  | 
))/ __      `|__|
_(____nm______ww 
'where sceneId = 17;
go

update Scenes set textImage = '
+---------------------------------+
|                                 |
|           CRUISE BAR            |
|                                 |
|        12 Pacific Avenue        |
|       Melbourne, VIC 3000       |
|         (66) xxx-xxxx           |
|              4 A.M.             |
|  Prosecco               $25.00  |
|  Chateau Margaux        $55.00  |
|  Heidsieck              $49.00  |
|  Chateau Cheval Blanc	  $45.00  |
|  TOTAL                 $xxx.xx  |
|  Credit                $xxx.xx  |
|  Change                $20.00   |
|          THANK YOU!             |
+---------------------------------+'where sceneId = 19;
go

--select * from Choices
--go
--select * from Scenes
--go

create table EndingEndPoints(
	sceneID int foreign key references Scenes(sceneId),
	counter int,
	primary key (sceneID)
)
go

create table EndingEndPoints(
	sceneID int foreign key references Scenes(sceneId),
	counter int,
	primary key (sceneID)
)
go


insert into EndingEndPoints(sceneID, counter)
	select sceneID, '0' from Scenes where ending = 'bad' or ending = 'good'
go

create procedure getCounterAtEnding
(
	@sceneID int
)as select counter, sceneID from EndingEndPoints where sceneID = @sceneID;
go

create procedure updateCounterAtEnding(
	@sceneID int
)as update EndingEndPoints set counter = counter + 1 where sceneID = @sceneID;
go

select * from EndingEndPoints
go

getCounterAtEnding 7;
go

