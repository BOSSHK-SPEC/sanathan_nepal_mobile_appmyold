import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class DescriptionScreenFestivals extends StatelessWidget {
  const DescriptionScreenFestivals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(6), bottomLeft: Radius.circular(6)),
          color: themeProvider.bookAppointmentBackground,
        ),
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 22, right: 8),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 155,
                    width: 150,
                    child: Image.asset('assets/images/Rectangle 1059 (2).png'),
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 8, left: 8),
                      height: 170,
                      width: 200,
                      child: const Text(
                        'जसका नूतनकमलदलतुल्य प्रसन्न नयन (दृष्टि) वामभागमा विराजमान श्री सीताजीका मुखकमलमा अडिएका छन्, उनै आजानुबाहु धनुषबाण धारण गर्नुभएका बद्धपद्मासनमा विराजमान पीताम्बरधारी विशाल जटाजूटले युक्त मेघश्याम नाना अलंकारले विभूषित दशरथनन्दन भगवान् श्रीरामचन्द्रको सभक्ति ध्यान गर्दै आज रामनवमी को पावन दिनमा भगवानका केही गुणानुवादको चर्चा गरिनेछ। ध्यायेदाजानुबाहुं धृतशरधनुषं बद्धपद्मासनस्थं। पीतं वासोवसानं नवकमलदलस्पर्धिनेत्रं प्रसन्नम्।। वामाङ्कारूढसीतामुखकमलमिलल्लोचनं नीरदाभं,।',
                        style: TextStyle(fontSize: 12),
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                'जसका नूतनकमलदलतुल्य प्रसन्न नयन (दृष्टि) वामभागमा विराजमान श्री सीताजीका मुखकमलमा अडिएका छन्, उनै आजानुबाहु धनुषबाण धारण गर्नुभएका बद्धपद्मासनमा विराजमान पीताम्बरधारी विशाल जटाजूटले युक्त मेघश्याम नाना अलंकारले विभूषित दशरथनन्दन भगवान् श्रीरामचन्द्रको सभक्ति ध्यान गर्दै रामनवमी को पावन दिनमा भगवानका केही गुणानुवादको चर्चा गरिनेछ। ध्यायेदाजानुबाहुं धृतशरधनुषं बद्धपद्मासनस्थं। पीतं वासोवसानं नवकमलदलस्पर्धिनेत्रं प्रसन्नम्।। वामाङ्कारूढसीतामुखकमलमिलल्लोचनं नीरदाभं।',
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
