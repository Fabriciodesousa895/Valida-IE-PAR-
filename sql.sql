CREATE OR REPLACE NONEDITIONABLE FUNCTION VALIDA_IE_PA (P_IE VARCHAR)
RETURN VARCHAR
IS
V_COUNT INT;
V_RESPONSE VARCHAR(50);
BEGIN
      --VALIDA SE IE TEM 9 DIGITOS
      IF LENGTH(P_IE) <> 9 THEN
        RAISE_APPLICATION_ERROR(-20225,'IE deve ter 9 digitos');
      END IF;
      --CALCULA O RESTO DA DIVISÃO
      V_COUNT := MOD(SUBSTR(P_IE,8,1) * 2 +
                 SUBSTR(P_IE,7,1) * 3 +
                 SUBSTR(P_IE,6,1) * 4 +
                 SUBSTR(P_IE,5,1) * 5 +
                 SUBSTR(P_IE,4,1) * 6 +
                 SUBSTR(P_IE,3,1) * 7 +
                 SUBSTR(P_IE,2,1) * 8 +
                 SUBSTR(P_IE,1,1) * 9 ,11);
       --VALIDA SE O RESTO DA DIVISÃO É 0 OU 1 E SE O  DIGITO VERIFICADOR IGUAL A ZERO      
       IF V_COUNT IN (1,0) AND SUBSTR(P_IE,9,1) = 0  THEN
         
             V_RESPONSE := 'IE é válida';
       
       ELSE 
        --RESTO DA DIVISÃO  DIFERENTE DE 0 OU  1,VALIDA COM O DIGITO VERIFICADOR 
       IF 11 - V_COUNT = SUBSTR(P_IE,9,1) THEN
              V_RESPONSE := 'IE é válida';
       ELSE
         RAISE_APPLICATION_ERROR(-20226,'IE não é válida!');
       END IF;
       
       END IF;
       
  RETURN V_RESPONSE;

END;
