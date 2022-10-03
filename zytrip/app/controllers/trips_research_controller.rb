class TripsResearchController < ApplicationController
  def survey
  end

  def results

    @trips = Trip.all

    # ------------ 0) Filters ------------ #

    if (params[:iberic] || params[:europe] || params[:africa] || params[:asia] || params[:america])

      @filter_destination = true

      if params[:iberic]
        @message_destination = "Rutas Ibéricas"
      elsif params[:europe]
        @message_destination = "Europe"
      elsif params[:africa]
        @message_destination = "África"
      elsif params[:asia]
        @message_destination = "Asia"
      else
        @message_destination = "América"
      end
    else
      @filter_destination = false
      @message_destination = "No especificado"
    end

    if (params[:maxp500] || params[:betwp510] || params[:betwp1015] || params[:minp1500])

      @filter_budget = true

      if params[:maxp500]
        @message_budget = "Menos de 500€"
      elsif params[:betwp510]
        @message_budget = "500€-1000€"
      elsif params[:betwp1015]
        @message_budget = "1000€-1500€"
      else
        @message_budget = "Más de 1500€"
      end
    else
      @filter_budget = false
      @message_budget = "No especificado"
    end

    if (params[:maxd3] || params[:betwd35] || params[:betwd57] || params[:minweek])

      @filter_duration = true

      if params[:maxd3]
        @message_duration = "Menos de 3 días"
      elsif params[:betwd35]
        @message_duration = "3-5 días"
      elsif params[:betwd57]
        @message_duration = "5-7 días"
      else
        @message_duration = "Más de una semana"
      end
    else
      @filter_duration = false
      @message_duration = "No especificado"
    end

    if (params[:gastronomy] || params[:lodging] || params[:activities])

      @filter_services = true

      if params[:gastronomy]
        @message_services = "gastronomía"
      elsif params[:lodging]
        @message_services = "estancia"
      else
        @message_services = "actividades"
      end
    else
      @filter_services = false
      @message_services = "No especificado"
    end

    if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

      @filter_company = true

      if params[:family]
        @message_company = "Viaje familiar"
      elsif params[:romantic]
        @message_company = "Escapada romántica"
      elsif params[:friends]
        @message_company = "Viaje con amigos"
      elsif params[:alone]
        @message_company = "Viaje por tu cuenta"
      else
        @message_company = "Conocer gente nueva"
      end
    else
      @filter_company = false
      @message_company = "No especificado"
    end

    if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

      @filter_topic = true

      if params[:beach]
        @message_topic = "Playa"
      elsif params[:nature]
        @message_topic = "Naturaleza"
      elsif params[:relax]
        @message_topic = "Descansar"
      else
        @message_topic = "Turismo y cultura"
      end
    else
      @filter_topic = false
      @message_topic = "No especificado"
    end




    # ------------ 1) destination ------------ #

    if (params[:iberic] || params[:europe] || params[:africa] || params[:asia] || params[:america])
      
      @destination_trips = []

      if params[:iberic]
        @trips.each do |t|
          if t.preference.destination_spain?
            @destination_trips << t
          end
        end
      elsif params[:europe]
        @trips.each do |t|
          if t.preference.destination_europe?
            @destination_trips << t
          end
        end
      elsif params[:america]
        @trips.each do |t|
          if t.preference.destination_america?
            @destination_trips << t
          end
        end
      elsif params[:africa]
        @trips.each do |t|
          if t.preference.destination_africa?
            @destination_trips << t
          end
        end
      else
        @trips.each do |t|
          if t.preference.destination_asia?
            @destination_trips << t
          end
        end
      end

      # ------------ 2) budget ------------ #

      if (params[:maxp500] || params[:betwp510] || params[:betwp1015] || params[:minp1500])

        @budget_trips = []

        if params[:maxp500]
          @destination_trips.each do |t|
            if t.preference.budget_low?
              @budget_trips << t
            end
          end
        elsif params[:betwp510]
          @destination_trips.each do |t|
            if t.preference.budget_medium?
              @budget_trips << t
            end
          end
        elsif params[:betwp1015]
          @destination_trips.each do |t|
            if t.preference.budget_high?
              @budget_trips << t
            end
          end
        else
          @destination_trips.each do |t|
            if t.preference.budget_expensive?
              @budget_trips << t
            end
          end
        end

        # ------------ 3) duration ------------ #

        if (params[:maxd3] || params[:betwd35] || params[:betwd57] || params[:minweek])

          @duration_trips = []

          if params[:maxd3]
            @budget_trips.each do |t|
              if t.preference.duration_short?
                @duration_trips << t
              end
            end
          elsif params[:betwd35]
            @budget_trips.each do |t|
              if t.preference.duration_ordinary?
                @duration_trips << t
              end
            end
          elsif params[:betwd57]
            @budget_trips.each do |t|
              if t.preference.duration_long?
                @duration_trips << t
              end
            end
          else
            @budget_trips.each do |t|
              if t.preference.duration_overlong?
                @duration_trips << t
              end
            end
          end

          # ------------ 4) Services ------------ #

          if (params[:gastronomy] || params[:lodging] || params[:activities])

            @services_trips = []

            if params[:gastronomy]
              @duration_trips.each do |t|
                if t.preference.remarkable_gastronomy?
                  @services_trips << t
                end
              end
            elsif params[:lodging]
              @duration_trips.each do |t|
                if t.preference.remarkable_lodging?
                  @services_trips << t
                end
              end
            else
              @duration_trips.each do |t|
                if t.preference.remarkable_activities?
                  @services_trips << t
                end
              end
            end

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            end

          # ------------ 4) No services ------------ #
          else
            @services_trips = @duration_trips

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end
              
            end
          end

        # ------------ 3) No duration ------------ #
        else
          @duration_trips = @budget_trips

          # ------------ 4) Services ------------ #

          if (params[:gastronomy] || params[:lodging] || params[:activities])

            @services_trips = []

            if params[:gastronomy]
              @duration_trips.each do |t|
                if t.preference.remarkable_gastronomy?
                  @services_trips << t
                end
              end
            elsif params[:lodging]
              @duration_trips.each do |t|
                if t.preference.remarkable_lodging?
                  @services_trips << t
                end
              end
            else
              @duration_trips.each do |t|
                if t.preference.remarkable_activities?
                  @services_trips << t
                end
              end
            end

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            end

          # ------------ 4) No services ------------ #
          else
            @services_trips = @duration_trips

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end
              
            end
          end
        end


      # ------------ 2) No budget ------------ #
      else

        @budget_trips = @destination_trips

        # ------------ 3) duration ------------ #

        if (params[:maxd3] || params[:betwd35] || params[:betwd57] || params[:minweek])

          @duration_trips = []

          if params[:maxd3]
            @budget_trips.each do |t|
              if t.preference.duration_short?
                @duration_trips << t
              end
            end
          elsif params[:betwd35]
            @budget_trips.each do |t|
              if t.preference.duration_ordinary?
                @duration_trips << t
              end
            end
          elsif params[:betwd57]
            @budget_trips.each do |t|
              if t.preference.duration_long?
                @duration_trips << t
              end
            end
          else
            @budget_trips.each do |t|
              if t.preference.duration_overlong?
                @duration_trips << t
              end
            end
          end

          # ------------ 4) Services ------------ #

          if (params[:gastronomy] || params[:lodging] || params[:activities])

            @services_trips = []

            if params[:gastronomy]
              @duration_trips.each do |t|
                if t.preference.remarkable_gastronomy?
                  @services_trips << t
                end
              end
            elsif params[:lodging]
              @duration_trips.each do |t|
                if t.preference.remarkable_lodging?
                  @services_trips << t
                end
              end
            else
              @duration_trips.each do |t|
                if t.preference.remarkable_activities?
                  @services_trips << t
                end
              end
            end

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            end

          # ------------ 4) No services ------------ #
          else
            @services_trips = @duration_trips

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end
              
            end
          end

        # ------------ 3) No duration ------------ #
        else
          @duration_trips = @budget_trips

          # ------------ 4) Services ------------ #

          if (params[:gastronomy] || params[:lodging] || params[:activities])

            @services_trips = []

            if params[:gastronomy]
              @duration_trips.each do |t|
                if t.preference.remarkable_gastronomy?
                  @services_trips << t
                end
              end
            elsif params[:lodging]
              @duration_trips.each do |t|
                if t.preference.remarkable_lodging?
                  @services_trips << t
                end
              end
            else
              @duration_trips.each do |t|
                if t.preference.remarkable_activities?
                  @services_trips << t
                end
              end
            end

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            end

          # ------------ 4) No services ------------ #
          else
            @services_trips = @duration_trips

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end
              
            end
          end

        end

      end


    # ------------ 1) No destination ------------ #
    else
      @destination_trips = Trip.all

      # ------------ 2) budget ------------ #

      if (params[:maxp500] || params[:betwp510] || params[:betwp1015] || params[:minp1500])

        @budget_trips = []

        if params[:maxp500]
          @destination_trips.each do |t|
            if t.preference.budget_low?
              @budget_trips << t
            end
          end
        elsif params[:betwp510]
          @destination_trips.each do |t|
            if t.preference.budget_medium?
              @budget_trips << t
            end
          end
        elsif params[:betwp1015]
          @destination_trips.each do |t|
            if t.preference.budget_high?
              @budget_trips << t
            end
          end
        else
          @destination_trips.each do |t|
            if t.preference.budget_expensive?
              @budget_trips << t
            end
          end
        end

        # ------------ 3) duration ------------ #

        if (params[:maxd3] || params[:betwd35] || params[:betwd57] || params[:minweek])

          @duration_trips = []

          if params[:maxd3]
            @budget_trips.each do |t|
              if t.preference.duration_short?
                @duration_trips << t
              end
            end
          elsif params[:betwd35]
            @budget_trips.each do |t|
              if t.preference.duration_ordinary?
                @duration_trips << t
              end
            end
          elsif params[:betwd57]
            @budget_trips.each do |t|
              if t.preference.duration_long?
                @duration_trips << t
              end
            end
          else
            @budget_trips.each do |t|
              if t.preference.duration_overlong?
                @duration_trips << t
              end
            end
          end

          # ------------ 4) Services ------------ #

          if (params[:gastronomy] || params[:lodging] || params[:activities])

            @services_trips = []

            if params[:gastronomy]
              @duration_trips.each do |t|
                if t.preference.remarkable_gastronomy?
                  @services_trips << t
                end
              end
            elsif params[:lodging]
              @duration_trips.each do |t|
                if t.preference.remarkable_lodging?
                  @services_trips << t
                end
              end
            else
              @duration_trips.each do |t|
                if t.preference.remarkable_activities?
                  @services_trips << t
                end
              end
            end

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            end

          # ------------ 4) No services ------------ #
          else
            @services_trips = @duration_trips

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end
              
            end
          end

        # ------------ 3) No duration ------------ #
        else
          @duration = @budget_trips

          # ------------ 4) Services ------------ #

          if (params[:gastronomy] || params[:lodging] || params[:activities])

            @services_trips = []

            if params[:gastronomy]
              @duration_trips.each do |t|
                if t.preference.remarkable_gastronomy?
                  @services_trips << t
                end
              end
            elsif params[:lodging]
              @duration_trips.each do |t|
                if t.preference.remarkable_lodging?
                  @services_trips << t
                end
              end
            else
              @duration_trips.each do |t|
                if t.preference.remarkable_activities?
                  @services_trips << t
                end
              end
            end

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            end

          # ------------ 4) No services ------------ #
          else
            @services_trips = @duration_trips

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end
              
            end
          end
        end


      # ------------ 2) No budget ------------ #
      else

        @budget_trips = @destination_trips

        # ------------ 3) duration ------------ #

        if (params[:maxd3] || params[:betwd35] || params[:betwd57] || params[:minweek])

          @duration_trips = []

          if params[:maxd3]
            @budget_trips.each do |t|
              if t.preference.duration_short?
                @duration_trips << t
              end
            end
          elsif params[:betwd35]
            @budget_trips.each do |t|
              if t.preference.duration_ordinary?
                @duration_trips << t
              end
            end
          elsif params[:betwd57]
            @budget_trips.each do |t|
              if t.preference.duration_long?
                @duration_trips << t
              end
            end
          else
            @budget_trips.each do |t|
              if t.preference.duration_overlong?
                @duration_trips << t
              end
            end
          end

          # ------------ 4) Services ------------ #

          if (params[:gastronomy] || params[:lodging] || params[:activities])

            @services_trips = []

            if params[:gastronomy]
              @duration_trips.each do |t|
                if t.preference.remarkable_gastronomy?
                  @services_trips << t
                end
              end
            elsif params[:lodging]
              @duration_trips.each do |t|
                if t.preference.remarkable_lodging?
                  @services_trips << t
                end
              end
            else
              @duration_trips.each do |t|
                if t.preference.remarkable_activities?
                  @services_trips << t
                end
              end
            end

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            end

          # ------------ 4) No services ------------ #
          else
            @services_trips = @duration_trips

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end
              
            end
          end

        # ------------ 3) No duration ------------ #
        else
          @duration_trips = @budget_trips

          # ------------ 4) Services ------------ #

          if (params[:gastronomy] || params[:lodging] || params[:activities])

            @services_trips = []

            if params[:gastronomy]
              @duration_trips.each do |t|
                if t.preference.remarkable_gastronomy?
                  @services_trips << t
                end
              end
            elsif params[:lodging]
              @duration_trips.each do |t|
                if t.preference.remarkable_lodging?
                  @services_trips << t
                end
              end
            else
              @duration_trips.each do |t|
                if t.preference.remarkable_activities?
                  @services_trips << t
                end
              end
            end

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            end

          # ------------ 4) No services ------------ #
          else
            @services_trips = @duration_trips

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism] || params[:relax])

                @topic_trips = []

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:relax]
                  @company_trips.each do |t|
                    if t.preference.relax_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @result_trips = @company_trips
              end
              
            end
          end
        end
      end
    end
  end
end
