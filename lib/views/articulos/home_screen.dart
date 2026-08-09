import 'package:flutter/material.dart';
import 'package:prestapp/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/Articulo_controller.dart';
import '../../models/Articulo_model.dart';
import '../../widgets/objeto_list_tile.dart';
import '../../views/ajustes_screen.dart';
import '../prestamos/historial_screen.dart';
import 'create_screen.dart';
import 'detail_screen.dart';
import 'edit_screen.dart';

/// Pantalla principal: lista vertical de artículos con su estado
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ArticuloController _controller = ArticuloController();
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarArticulos();
  }

  Future<void> _cargarArticulos() async {
    await _controller.CargarArticulos();
    if (!mounted) return;
    setState(() => _cargando = false);
  }

  int get _disponibles =>
      _controller.articulos.where((a) => !a.estaPrestado).length;

  void _abrirDetalle(Articulo articulo) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetalleScreen(articulo: articulo)),
    );
    await _cargarArticulos();
  }

  void _abrirCrear() async {
    final creado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CrearScreen()),
    );
    if (creado == true) {
      await _cargarArticulos();
    }
  }

  void _mostrarOpciones(Articulo articulo) {
    final t = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: Text(t.editar),
              onTap: () async {
                Navigator.pop(ctx);
                if(articulo.estaPrestado != true) {
                  final actualizado = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditarScreen(articulo: articulo),
                    ),
                  );

                  if (actualizado == true) {
                    await _cargarArticulos();
                  }
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(t.noSePuedeEditarPrestado),
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(16),
                      duration: const Duration(seconds: 2)
                  ),
                  );
                }

              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.delete_outline, color: Color(0xFF8B3A3A)),
              title: Text(t.eliminar),
              onTap: () async {
                Navigator.pop(ctx);
                if (articulo.id != null && articulo.estaPrestado != true ) {
                  await _controller.EliminarArticulo(articulo.id!);
                  await _cargarArticulos();
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(t.noSePuedeEliminarPrestado),
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(16),
                    duration: const Duration(seconds: 2)
                  ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: Text(
          'PrestApp',
          style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_outlined, size: 22),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistorialScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, size: 22),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AjustesScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8, bottom: 12),
                  child: Text(
                    t.objetoDisponible(_disponibles),
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: _controller.articulos.isEmpty
                      ? Center(
                          child: Text(
                            t.listaVacia,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: _controller.articulos.length,
                          itemBuilder: (context, index) {
                            final articulo = _controller.articulos[index];
                            return ObjetoListTile(
                              articulo: articulo,
                              onTap: () => _abrirDetalle(articulo),
                              onMenuTap: () => _mostrarOpciones(articulo),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: _abrirCrear,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
