import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

/*
 -Corporation CodyCod

 -Libreria desarrollado por JeancaDeve, todos los derechos reservados 2024 © - JeancaDeve-Perú 
 */

//* Retorna el ancho segun el pocentaje de la pantalla indicado
double widthPercentageScreenCc(BuildContext context,
    {double percentage = 100}) {
  return MediaQuery.of(context).size.width * (percentage / 100);
}

//* Retorna el alto segun el porcentaje de pantalla indicado
double heightPercentageScreenCc(BuildContext context,
    {double? percentage = 100}) {
  return MediaQuery.of(context).size.height * (percentage! / 100);
}

//* Imagen de fondo de la aplicacion
//todo: proximo cambio, agregar la capa como color degradable
class BackGroundImageCc extends StatelessWidget {
  final String urlImage; //esta sera la url de la imagen, asset o network
  final Widget child;
  final Color?
      colorLayer; // color de la capa, por ejemplo para agregar opacidad al fondo
  final double? paddingHorizontal;
  final double?
      paddingVertical; // margenes para que el contenido no este pegado a los extremos
  const BackGroundImageCc(
      {super.key,
      required this.urlImage,
      required this.child,
      this.colorLayer,
      this.paddingHorizontal,
      this.paddingVertical});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        urlImage.substring(0, 4) !=
                'http' //si la url empieza con http quiere decir que es de tipo network, si no asset
            ? Image.asset(
                urlImage,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              )
            : Image.network(
                urlImage,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: colorLayer, //este sera el contenedor que servira como capa
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: paddingHorizontal ?? 0,
              vertical: paddingVertical ?? 0),
          child: child,
        )
      ],
    );
  }
}

//*Cambiar de pantalla sin guardar pantallas en la pila de navegacion

void changeScreenCc(
    {required BuildContext context, required Widget newScreen}) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => newScreen));
}

//*Metodo para cambiar de aspecto la barra de estado, barra de navegacion e iconos de bn

void configureStatusBarColorAndOthersCc(
    {Color statusBarColor = Colors.transparent,
    Color systemNavigationBarColor = Colors.transparent,
    Brightness systemNavigationBarIconBrightness = Brightness.light}) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: statusBarColor, //Color transparente para la barra de estado
    systemNavigationBarColor:
        systemNavigationBarColor, //Color transparente para la barra de navegación
    systemNavigationBarIconBrightness:
        systemNavigationBarIconBrightness, //Iconos de la barra de navegación en color claro
  ));
}

//* Este es un text formfield personalizado

class TextFormFieldCc extends StatelessWidget {
  final double? height;
  final String? hintText;
  final Color? bgColor;
  final TextStyle? fontStyle;
  final TextStyle? hintStyle;
  final TextEditingController controller;
  final IconData? suffixIcon;
  final VoidCallback? suffixOnPressed;
  final IconData? prefixIcon;
  final VoidCallback? prefixOnPressed;
  final Color? colorSuffixIcon;
  final double? sizeSuffixIcon;
  final Color? colorPrefixIcon;
  final double? sizePrefixIcon;
  final double? width;
  const TextFormFieldCc(
      {super.key,
      this.height,
      this.hintText,
      required this.controller,
      this.bgColor = const Color.fromARGB(140, 168, 168, 168),
      this.fontStyle,
      this.hintStyle,
      this.suffixIcon,
      this.suffixOnPressed,
      this.prefixIcon,
      this.prefixOnPressed,
      this.colorSuffixIcon,
      this.sizeSuffixIcon,
      this.colorPrefixIcon,
      this.sizePrefixIcon,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(40)),
      child: TextField(
          style: fontStyle,
          controller: controller,
          //verifica si suffix icon existe para que se muestre, si no no se muestra nada
          decoration: InputDecoration(
              suffixIcon: suffixIcon != null
                  ? IconButton(
                      onPressed: suffixOnPressed,
                      icon: Icon(
                        suffixIcon,
                        color: colorSuffixIcon,
                        size: sizeSuffixIcon,
                      ))
                  : null,
              prefixIcon: prefixIcon != null
                  ? IconButton(
                      onPressed: suffixOnPressed,
                      icon: Icon(
                        prefixIcon,
                        color: colorPrefixIcon,
                        size: sizePrefixIcon,
                      ))
                  : null,
              hintText: hintText,
              border: InputBorder.none,
              hintStyle: hintStyle)),
    );
  }
}

//* Devuelve la hora que se actuliza automaticamente
class ClockCc extends StatefulWidget {
  final TextStyle? textStyle;
  const ClockCc({super.key, this.textStyle});

  @override
  State<ClockCc> createState() => _ClockCcState();
}

class _ClockCcState extends State<ClockCc> {
  Stream<DateTime> clockStream = Stream<DateTime>.periodic(
      const Duration(seconds: 1), (_) => DateTime.now());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: clockStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final date = snapshot.data!;

          String hour =
              snapshot.data!.hour < 10 ? '0${date.hour}' : '${date.hour}';
          String minute =
              snapshot.data!.minute < 10 ? '0${date.minute}' : '${date.minute}';
          String second =
              snapshot.data!.second < 10 ? '0${date.second}' : '${date.second}';

          String hourComplete = '$hour:$minute:$second';

          return Text(hourComplete, style: widget.textStyle);
        } else {
          return Text(
            'Loading...',
            style: widget.textStyle,
          );
        }
      },
    );
  }
}

//* este es un boton personalizado

class ButtonPrimaryCc extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final Color bgColor;
  final Color
      colorData; //cambiar el color del icono y texto del boton, por defecto es blanco
  final double? iconSize;
  const ButtonPrimaryCc(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.icon,
      this.width,
      this.height,
      this.textStyle,
      this.bgColor = Colors.blueAccent,
      this.colorData = Colors.white,
      this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(20)),
        child: TextButton.icon(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: colorData,
            size: iconSize,
          ),
          label: Text(
            text,
            style: textStyle ?? TextStyle(color: colorData),
          ),
        ));
  }
}

//todo: Este es un boton como icono que cambia al ser presionado

//todo:  Añadir animaciones a los botones

//todo: imagen que aumenta su tamaño cada que se toca

