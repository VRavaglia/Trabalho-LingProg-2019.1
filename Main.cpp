#include <fstream>
#include <iostream>
#include "Desenhador.h"
#include "Engine.h"
#include "Menu.h"
#include "VariaveisConfig.h"


int main(){
    Engine engine;
    Menu menu(engine);
    menu.exibe();
}
