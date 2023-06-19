import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/radio_api.dart';
import 'package:flutter_application_1/providers/radio_provider.dart';
import 'package:flutter_application_1/widgets/radio_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:volume_controller/volume_controller.dart';
import 'favorites_list.dart';

class RadioPlayer extends StatefulWidget {
  const RadioPlayer({super.key});

  @override
  State<RadioPlayer> createState() => _RadioPlayerState();
}

class _RadioPlayerState extends State<RadioPlayer>
    with SingleTickerProviderStateMixin {
  // Déclaration des variables d'animation et de l'état des boutons
  late AnimationController animationController;
  late VolumeController volumeController;
  late Animation<Offset> radioOffset;
  late Animation<Offset> radioListOffset;

  bool listEnabled = false;
  bool isPlaying = true;
  bool isMuted = false;
  bool isRadioListSelected = true;

  // Fonction pour basculer entre les listes de radios et les favoris
  void toggleSelected(bool value) {
    setState(() {
      isRadioListSelected = value;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    // Initialisation des variables d'animation et de l'état des boutons
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    radioListOffset = Tween(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );
    radioOffset = Tween(
      begin: const Offset(0, 0.3),
      end: const Offset(0, 0.1),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ),
    );
    // Écouteur de l'état de lecture de la radio
    RadioApi.player.stateStream.listen((event) {
      setState(() {
        isPlaying = event;
      });
    });
    volumeController = VolumeController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Zone d'affichage de la radio en cours de lecture
        Expanded(
          child: SlideTransition(
          position: radioOffset,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 220,
                width: 220,
                color: Colors.transparent,
                child: Consumer<RadioProvider>(builder: ((context,value,child){
                  return Image.network(
                    value.station.photoUrl,
                    fit: BoxFit.fill,
                  );
                })),
              ),
              // Boutons de contrôle de la radio
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        listEnabled = !listEnabled;
                      });
                      switch(animationController.status){
                        case AnimationStatus.dismissed :
                          animationController.forward();
                          break;
                        case AnimationStatus.completed:
                          animationController.reverse();
                          break;

                        default:
                      }
                    },
                    color: listEnabled ? Colors.amber : Colors.black,
                    iconSize: 30,
                    icon: const Icon(
                      Icons.list,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      isPlaying ? RadioApi.player.stop() : RadioApi.player.play();
                    },
                    color: Colors.black,
                    iconSize: 30,
                    icon: Icon(
                      isPlaying ? Icons.stop : Icons.play_arrow,
                    ),
                  ),

                  IconButton(
                    onPressed: () async {
                    if(isMuted){
                      volumeController.setVolume(0.5);
                    }
                    else{
                      volumeController.muteVolume();
                    }
                    setState(() {
                      isMuted = !isMuted;
                    });
                    },
                    color: Colors.black,
                    iconSize: 30,
                    icon:  Icon(
                     isMuted ? Icons.volume_off : Icons.volume_up,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        ),
        SlideTransition(
          position: radioListOffset,
          child: Container(
            height: 280,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(
                  40,
                ),
              ),
            ),
            child:  Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left : 30.0,top: 20.0,right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          toggleSelected(true);
                        },
                        child: Text(
                          'Radio List',
                          style: GoogleFonts.openSans(
                            fontSize: 20,
                            fontWeight: isRadioListSelected ? FontWeight.bold : FontWeight.normal,
                            color: Colors.amber[900],
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          toggleSelected(false);
                        },
                        child: Text(
                          'My Favorites',
                          style: GoogleFonts.openSans(
                            fontSize: 20,
                            fontWeight: !isRadioListSelected ? FontWeight.bold : FontWeight.normal,
                            color: Colors.amber[900],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  indent: 30,
                  endIndent: 30,
                ),
                Expanded(
                  child: isRadioListSelected ? RadioList() : FavoritesList(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
